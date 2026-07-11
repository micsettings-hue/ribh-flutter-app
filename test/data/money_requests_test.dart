import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:ribh/core/failures/failure.dart';
import 'package:ribh/data/models/models.dart';
import 'package:ribh/data/payments/payment_gateway.dart';
import 'package:ribh/data/repositories/wallet_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

SupabaseClient clientWith(MockClient httpClient) => SupabaseClient(
  'http://localhost:54321',
  'test-key',
  httpClient: httpClient,
);

http.Response json200(Object body, http.Request request) => http.Response(
  jsonEncode(body),
  200,
  headers: {'content-type': 'application/json'},
  request: request,
);

http.Response postgrestError(String message, http.Request request) =>
    http.Response(
      jsonEncode({
        'message': message,
        'code': 'P0001',
        'details': null,
        'hint': null,
      }),
      400,
      headers: {'content-type': 'application/json'},
      request: request,
    );

void main() {
  group('WalletRepository money requests', () {
    test(
      'requestDeposit calls the RPC with method, amount, reference',
      () async {
        late http.Request seen;
        final repo = WalletRepository(
          clientWith(
            MockClient((request) async {
              seen = request;
              expect(request.url.path, endsWith('/rpc/request_deposit'));
              return json200('request-uuid-1', request);
            }),
          ),
        );

        final result = await repo.requestDeposit(
          method: PaymentMethod.bank,
          amount: 100000,
          reference: 'RIBH-42',
        );

        expect(result.valueOrNull, 'request-uuid-1');
        final params = jsonDecode(seen.body) as Map<String, dynamic>;
        expect(params['p_method'], 'bank');
        expect(params['p_amount'], 100000);
        expect(params['p_reference'], 'RIBH-42');
      },
    );

    test('requestWithdrawal maps insufficient_funds', () async {
      final repo = WalletRepository(
        clientWith(
          MockClient(
            (request) async => postgrestError('insufficient_funds', request),
          ),
        ),
      );
      final result = await repo.requestWithdrawal(
        method: PaymentMethod.bkash,
        amount: 999999,
      );
      expect(result.failureOrNull, isA<InsufficientFundsFailure>());
    });

    test('requestDeposit maps not_verified for KYC tier 0', () async {
      final repo = WalletRepository(
        clientWith(
          MockClient(
            (request) async => postgrestError('not_verified', request),
          ),
        ),
      );
      final result = await repo.requestDeposit(
        method: PaymentMethod.nagad,
        amount: 5000,
      );
      expect(result.failureOrNull, isA<NotVerifiedFailure>());
    });

    test('reference_required maps to a ValidationFailure', () async {
      final repo = WalletRepository(
        clientWith(
          MockClient(
            (request) async => postgrestError('reference_required', request),
          ),
        ),
      );
      final result = await repo.requestDeposit(
        method: PaymentMethod.bank,
        amount: 5000,
      );
      final failure = result.failureOrNull;
      expect(failure, isA<ValidationFailure>());
      expect(failure!.message, 'reference_required');
    });

    test('myMoneyRequests parses rows including status and kind', () async {
      final repo = WalletRepository(
        clientWith(
          MockClient(
            (request) async => json200([
              {
                'id': 'r1',
                'profile_id': 'u1',
                'kind': 'withdrawal',
                'method': 'bank',
                'amount': 70000,
                'reference': null,
                'status': 'pending',
                'tx_id': null,
                'decided_at': null,
                'created_at': '2026-07-12T10:00:00Z',
              },
            ], request),
          ),
        ),
      );
      final result = await repo.myMoneyRequests();
      final requests = result.valueOrNull!;
      expect(requests, hasLength(1));
      expect(requests.first.kind, MoneyRequestKind.withdrawal);
      expect(requests.first.status, MoneyRequestStatus.pending);
      expect(requests.first.amount, 70000);
    });
  });

  group('UnconnectedPaymentGateway', () {
    test(
      'is honest: no checkout available, start fails typed, no charge',
      () async {
        const gateway = UnconnectedPaymentGateway();
        for (final method in PaymentMethod.values) {
          expect(gateway.isCheckoutAvailable(method), isFalse);
        }
        final result = await gateway.startCheckout(
          MoneyRequest(
            id: 'r1',
            profileId: 'u1',
            kind: MoneyRequestKind.deposit,
            method: PaymentMethod.bkash,
            amount: 1000,
            status: MoneyRequestStatus.pending,
            createdAt: DateTime.utc(2026, 7, 12),
          ),
        );
        expect(result.failureOrNull, isA<GatewayNotConnectedFailure>());
      },
    );
  });
}
