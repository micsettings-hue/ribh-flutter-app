import 'package:flutter_test/flutter_test.dart';
import 'package:ribh/data/models/models.dart';

WalletTransaction tx(TxKind kind, int amount) => WalletTransaction(
  id: 'tx-${kind.name}-$amount',
  walletId: 'wallet-1',
  kind: kind,
  amount: amount,
  createdAt: DateTime.utc(2026, 7, 11),
);

void main() {
  group('ledger sign convention', () {
    test('deposit, distribution, and recovery are credits', () {
      for (final kind in [
        TxKind.deposit,
        TxKind.distribution,
        TxKind.recovery,
      ]) {
        expect(kind.isCredit, isTrue, reason: kind.name);
        expect(kind.signedAmount(500), 500, reason: kind.name);
      }
    });

    test('all other kinds are debits', () {
      for (final kind in [
        TxKind.investment,
        TxKind.payout,
        TxKind.purification,
        TxKind.writeDown,
        TxKind.sadaqah,
        TxKind.zakat,
      ]) {
        expect(kind.isCredit, isFalse, reason: kind.name);
        expect(kind.signedAmount(500), -500, reason: kind.name);
      }
    });
  });

  group('deriveBalance', () {
    test('empty ledger is zero', () {
      expect(deriveBalance(const []), 0);
    });

    test('deposit then invest then distribution then payout matches the '
        'SQL invariant test row set', () {
      // Same numbers as supabase/tests/ledger_invariant_test.sql.
      final ledger = [
        tx(TxKind.deposit, 100000),
        tx(TxKind.investment, 40000),
        tx(TxKind.distribution, 8000),
        tx(TxKind.payout, 3000),
      ];
      expect(deriveBalance(ledger), 65000);
    });

    test('every kind participates with its sign', () {
      final ledger = [
        tx(TxKind.deposit, 100000),
        tx(TxKind.investment, 20000),
        tx(TxKind.distribution, 5000),
        tx(TxKind.recovery, 1500),
        tx(TxKind.payout, 2000),
        tx(TxKind.purification, 300),
        tx(TxKind.writeDown, 700),
        tx(TxKind.sadaqah, 1000),
        tx(TxKind.zakat, 2500),
      ];
      expect(
        deriveBalance(ledger),
        100000 - 20000 + 5000 + 1500 - 2000 - 300 - 700 - 1000 - 2500,
      );
    });
  });
}
