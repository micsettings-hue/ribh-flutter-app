import 'package:freezed_annotation/freezed_annotation.dart';

enum UserRole { investor, business, admin }

enum TxKind {
  deposit,
  investment,
  distribution,
  payout,
  purification,
  @JsonValue('write_down')
  writeDown,
  recovery,
  sadaqah,
  zakat,
}

/// The ledger sign convention. Mirrors `public.ledger_signed_amount` in
/// supabase/migrations/20260711000200_ledger.sql; keep them in lockstep.
extension TxKindSign on TxKind {
  bool get isCredit => switch (this) {
    TxKind.deposit || TxKind.distribution || TxKind.recovery => true,
    _ => false,
  };

  int signedAmount(int amount) => isCredit ? amount : -amount;
}

enum CampaignStatus {
  open,
  running,
  matured,
  @JsonValue('in_recovery')
  inRecovery,
}

/// The exact string stored in Postgres, for query filters.
extension CampaignStatusDb on CampaignStatus {
  String get dbValue =>
      this == CampaignStatus.inRecovery ? 'in_recovery' : name;
}

enum PayoutRoute { bank, reinvest }

enum KycStatus { pending, approved, rejected }

/// AML requirement: the main origin of the money the user will invest.
enum KycSource {
  salary,
  @JsonValue('business_income')
  businessIncome,
  savings,
  remittance,
}

/// The exact string stored in Postgres.
extension KycSourceDb on KycSource {
  String get dbValue =>
      this == KycSource.businessIncome ? 'business_income' : name;
}

enum QueueStatus { pending, approved, declined }

enum WelfareKind { zakat, sadaqah }

enum ReferralStatus { joined, verified }

enum TreeSource { referral, sadaqah }
