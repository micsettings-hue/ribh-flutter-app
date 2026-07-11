import '../../app/l10n/app_localizations.dart';
import '../../data/models/models.dart';

/// Localized labels for money-rail enums, shared by the wallet screen and
/// the deposit and withdraw sheets.

String paymentMethodLabel(AppLocalizations l10n, PaymentMethod method) =>
    switch (method) {
      PaymentMethod.bkash => l10n.methodBkash,
      PaymentMethod.nagad => l10n.methodNagad,
      PaymentMethod.bank => l10n.methodBank,
    };

String requestKindLabel(AppLocalizations l10n, MoneyRequestKind kind) =>
    switch (kind) {
      MoneyRequestKind.deposit => l10n.requestKindDeposit,
      MoneyRequestKind.withdrawal => l10n.requestKindWithdrawal,
    };

String requestStatusLabel(AppLocalizations l10n, MoneyRequestStatus status) =>
    switch (status) {
      MoneyRequestStatus.pending => l10n.requestStatusPending,
      MoneyRequestStatus.confirmed => l10n.requestStatusConfirmed,
      MoneyRequestStatus.rejected => l10n.requestStatusRejected,
      MoneyRequestStatus.cancelled => l10n.requestStatusCancelled,
    };
