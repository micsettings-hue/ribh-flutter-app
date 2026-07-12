// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'RIBH';

  @override
  String get tabHome => 'Home';

  @override
  String get tabInvest => 'Invest';

  @override
  String get tabGrow => 'Grow';

  @override
  String get tabBarakah => 'Barakah';

  @override
  String get tabMe => 'Me';

  @override
  String get milestonePlaceholderBody =>
      'This area is not live yet. It arrives in an upcoming milestone with real data, not demo content.';

  @override
  String get retry => 'Retry';

  @override
  String get cancel => 'Cancel';

  @override
  String get errorNotConfigured =>
      'This build has no backend credentials configured, so nothing can load. Provide SUPABASE_URL and SUPABASE_PUBLISHABLE_KEY at build time.';

  @override
  String get errorNetwork =>
      'Network unavailable. Check your connection and try again.';

  @override
  String get errorAuth =>
      'You are signed out or the code was not accepted. Try again.';

  @override
  String get errorNotVerified => 'Identity verification is required first.';

  @override
  String get errorInsufficientFunds =>
      'Your available balance is not enough for this amount.';

  @override
  String errorUnknown(String detail) {
    return 'Something went wrong: $detail';
  }

  @override
  String get authTitle => 'Sign in';

  @override
  String get authIntro =>
      'Passwordless sign-in. We email you a one-time code; no password to remember or leak.';

  @override
  String get authEmailLabel => 'Email';

  @override
  String get authInvalidEmail => 'Enter a valid email address.';

  @override
  String get authSendCode => 'Send code';

  @override
  String authCodeSentTo(String email) {
    return 'Enter the code we sent to $email.';
  }

  @override
  String get authCodeLabel => 'One-time code';

  @override
  String get authVerify => 'Verify and continue';

  @override
  String get authChangeEmail => 'Use a different email';

  @override
  String get meAccount => 'Account';

  @override
  String get meSignOut => 'Sign out';

  @override
  String get meKycRow => 'Identity and KYC';

  @override
  String get meRiskRow => 'Risk tier';

  @override
  String get meMoreComing =>
      'Security and 2FA, nominee, statements, language and theme, Shariah board, and help arrive with the Me milestone.';

  @override
  String get kycStatusNone =>
      'Not started. Required before your first deposit.';

  @override
  String get kycStatusPending => 'Submitted. Pending verification review.';

  @override
  String kycStatusApproved(int tier) {
    return 'Tier $tier. Verified, source of funds on file.';
  }

  @override
  String get kycStatusRejected => 'Rejected. Please submit again.';

  @override
  String get riskTierUnset => 'Not set. Take the 3-question quiz.';

  @override
  String get riskTierShort => 'Short: steadier, shorter cycles';

  @override
  String get riskTierBalanced => 'Balanced: a sensible middle';

  @override
  String get riskTierDiversified => 'Diversified: widest spread of contracts';

  @override
  String get kycTitle => 'Verify identity';

  @override
  String kycStepLabel(int step) {
    return 'Step $step of 3';
  }

  @override
  String get kycStep1Body =>
      'Enter your National ID number exactly as printed. Only a one-way fingerprint of the number leaves this device.';

  @override
  String get kycNidLabel => 'NID number';

  @override
  String get kycNidInvalid => 'NID numbers are 10, 13, or 17 digits.';

  @override
  String get kycContinue => 'Continue';

  @override
  String get kycStep2Body =>
      'Liveness check: a selfie matched to your NID photo. Our verification provider is not connected yet, so this step is recorded as incomplete and your submission stays in review until it is verified. Nothing is faked.';

  @override
  String get kycStep2Continue => 'Continue without liveness';

  @override
  String get kycStep3Body =>
      'Source of funds, an AML requirement. Pick the main origin of the money you will invest.';

  @override
  String get kycSourceSalary => 'Salary';

  @override
  String get kycSourceBusiness => 'Business income';

  @override
  String get kycSourceSavings => 'Savings';

  @override
  String get kycSourceRemittance => 'Remittance';

  @override
  String get kycSubmit => 'Submit for verification';

  @override
  String get kycSubmitted =>
      'Submitted. Your tier upgrades only after real verification, and deposits stay locked until then.';

  @override
  String get riskQuizTitle => 'Risk tier quiz';

  @override
  String get riskQ1 => 'When do you expect to need this money?';

  @override
  String get riskQ1A1 => 'Within a year';

  @override
  String get riskQ1A2 => 'One to three years';

  @override
  String get riskQ1A3 => 'Three years or more';

  @override
  String get riskQ2 => 'If a campaign entered recovery, you would feel...';

  @override
  String get riskQ2A1 => 'Very uneasy, I want the safest path';

  @override
  String get riskQ2A2 => 'Concerned but patient';

  @override
  String get riskQ2A3 => 'Calm, I understand trade risk';

  @override
  String get riskQ3 => 'What matters most to you?';

  @override
  String get riskQ3A1 => 'Steadier, shorter cycles';

  @override
  String get riskQ3A2 => 'A sensible middle';

  @override
  String get riskQ3A3 => 'Widest spread of contracts';

  @override
  String get riskResultTitle => 'Your recommended tier';

  @override
  String get riskResultBody =>
      'Based on your answers. This is a recommendation, not advice, and you can change it anytime. Every deployment still needs your explicit approval. Returns are never guaranteed and capital is at risk.';

  @override
  String get riskSave => 'Save tier';

  @override
  String get errorGatewayNotConnected =>
      'No live payment checkout is connected in this build. Nothing has been charged.';

  @override
  String get homeWalletEntry => 'Amanah Wallet';

  @override
  String get homeWalletEntrySubtitle =>
      'Balance, ledger, deposits and withdrawals.';

  @override
  String get walletTitle => 'Wallet';

  @override
  String get walletBalanceLabel => 'Available balance';

  @override
  String get walletBalanceDerived =>
      'Derived from your append-only ledger, never stored.';

  @override
  String get walletAddFunds => 'Add funds';

  @override
  String get walletWithdraw => 'Withdraw';

  @override
  String get walletPendingRequests => 'Pending requests';

  @override
  String get walletLedger => 'Ledger';

  @override
  String get walletLedgerEmpty =>
      'No transactions yet. Your ledger starts with your first confirmed deposit.';

  @override
  String get txDeposit => 'Deposit';

  @override
  String get txInvestment => 'Investment';

  @override
  String get txDistribution => 'Profit distribution';

  @override
  String get txPayout => 'Payout';

  @override
  String get txPurification => 'Purification';

  @override
  String get txWriteDown => 'Write-down';

  @override
  String get txRecovery => 'Recovery';

  @override
  String get txSadaqah => 'Sadaqah';

  @override
  String get txZakat => 'Zakat';

  @override
  String get methodBkash => 'bKash';

  @override
  String get methodNagad => 'Nagad';

  @override
  String get methodBank => 'Bank transfer';

  @override
  String get requestKindDeposit => 'Deposit';

  @override
  String get requestKindWithdrawal => 'Withdrawal';

  @override
  String get requestStatusPending => 'Pending';

  @override
  String get requestStatusConfirmed => 'Confirmed';

  @override
  String get requestStatusRejected => 'Rejected';

  @override
  String get requestStatusCancelled => 'Cancelled';

  @override
  String get amountLabel => 'Amount in taka';

  @override
  String get invalidAmount =>
      'Enter an amount above zero, with at most two decimal places.';

  @override
  String get submitting => 'Submitting...';

  @override
  String get done => 'Done';

  @override
  String get requestRecordedTitle => 'Request recorded, pending';

  @override
  String get depositTitle => 'Add funds';

  @override
  String get depositReferenceLabel => 'Transfer reference';

  @override
  String get depositReferenceHelp =>
      'Use this reference in your bank transfer so we can match it to your request.';

  @override
  String get depositReferenceMissing =>
      'A transfer reference is required for bank deposits.';

  @override
  String get depositOwnAccountNote =>
      'Deposits must come from an account in your own name. Third-party deposits are refused at reconciliation.';

  @override
  String get depositSubmit => 'Record deposit request';

  @override
  String depositPendingNoCheckout(String method) {
    return '$method checkout is not connected in this build, so nothing has been charged. Your request stays pending until our team confirms a real payment. It never turns into a balance by itself.';
  }

  @override
  String get depositPendingCheckout =>
      'Complete the checkout that opens next. Your wallet is credited only after the provider confirms the payment.';

  @override
  String depositPendingBank(String reference) {
    return 'Transfer from your own account using reference $reference. Your wallet is credited after our team reconciles the transfer; until then this request stays pending.';
  }

  @override
  String get withdrawTitle => 'Withdraw';

  @override
  String withdrawAvailable(String amount) {
    return 'Available for withdrawal: $amount. Pending withdrawal requests are already excluded.';
  }

  @override
  String get withdrawTwoFaNote =>
      'Withdrawals will additionally require two-factor confirmation once 2FA ships. Until the payment rail is live, transfers are sent manually after review.';

  @override
  String get withdrawSubmit => 'Record withdrawal request';

  @override
  String get withdrawPendingBody =>
      'Your withdrawal request is recorded and pending review. The money leaves your balance only when the transfer is actually sent, and the ledger row appears then.';

  @override
  String get statusOpen => 'Open';

  @override
  String get statusRunning => 'Running';

  @override
  String get statusMatured => 'Matured';

  @override
  String get statusRecovery => 'In recovery';

  @override
  String get riskLow => 'Low risk';

  @override
  String get riskModerate => 'Moderate risk';

  @override
  String get riskElevated => 'Elevated risk';

  @override
  String get riskDisclosure =>
      'Projected, not guaranteed. Capital is at risk and returns depend on real trade outcomes.';

  @override
  String get marketSearchHint => 'Search campaigns';

  @override
  String get marketFilterAll => 'All';

  @override
  String get marketFilterOpen => 'Open';

  @override
  String get marketFilterMatured => 'Matured';

  @override
  String get marketFilterSaved => 'Saved';

  @override
  String get marketEmpty => 'No campaigns match. Adjust the filter or search.';

  @override
  String get marketSaveTooltip => 'Save to watchlist';

  @override
  String get marketUnsaveTooltip => 'Remove from watchlist';

  @override
  String marketFundedPercent(String percent) {
    return '$percent% funded';
  }

  @override
  String marketProjectedRate(String rate) {
    return '~$rate% p.a. projected';
  }

  @override
  String get campaignDetailTitle => 'Campaign';

  @override
  String campaignRaisedOfPool(String raised, String pool, String percent) {
    return '$raised raised of $pool ($percent%)';
  }

  @override
  String get campaignTermsTitle => 'Terms';

  @override
  String get campaignProfitPerLac => 'Projected profit per lac';

  @override
  String get campaignInvestorShare => 'Investor share';

  @override
  String get campaignTenureLabel => 'Tenure';

  @override
  String campaignTenureMonths(int months) {
    return '$months months';
  }

  @override
  String get campaignProjectedAnnualised => 'Projected annualised rate';

  @override
  String get campaignCalculatorTitle => 'Profit calculator';

  @override
  String campaignCalculatorResult(String profit, int months) {
    return 'Projected profit: $profit over $months months';
  }

  @override
  String get campaignContractBasis => 'Contract basis';

  @override
  String get contractExplainerMurabaha =>
      'Murabaha: Ribh purchases the goods the business needs and sells them on at a disclosed markup, paid over the tenure. Profit comes from the trade, not from lending money.';

  @override
  String get contractExplainerMusharakah =>
      'Musharakah: investors and the business contribute capital to a venture and share the actual profit or loss by agreed ratios. Loss is borne in proportion to capital.';

  @override
  String get contractExplainerGeneric =>
      'This campaign uses a trade-based contract reviewed for AAOIFI alignment. Details appear in the campaign documents.';

  @override
  String get campaignRecoveryTitle => 'Recovery in progress';

  @override
  String get campaignRecoveryBody =>
      'This campaign is in recovery: repayment is behind plan and Ribh is pursuing the outstanding amount with the business. Recoveries are credited to investors\' ledgers as they are collected. Outcomes are not guaranteed.';

  @override
  String get campaignInvestCta => 'Invest in this campaign';

  @override
  String get campaignNotOpen => 'This campaign is not open for new investment.';

  @override
  String get investSheetTitle => 'Confirm investment';

  @override
  String get investAck1 =>
      'I understand my capital is at risk and returns are projected, never guaranteed.';

  @override
  String get investAck2 =>
      'I understand my money is deployed for the full tenure and cannot be withdrawn early.';

  @override
  String get investAcksRequired =>
      'Both acknowledgements are required before you can invest.';

  @override
  String get investCommit => 'Commit investment';

  @override
  String get investCommittedTitle => 'Investment committed';

  @override
  String get investCommittedBody =>
      'Your investment and its ledger entry were written together in one transaction. You can see it in your portfolio and wallet ledger now.';

  @override
  String get homePortfolioTitle => 'Portfolio';

  @override
  String get homePortfolioEmpty =>
      'No investments yet. Open campaigns are on the Invest tab.';

  @override
  String portfolioInvested(String amount) {
    return '$amount invested';
  }

  @override
  String get amanahTitle => 'Amanah summary';

  @override
  String get amanahLedgerLink => 'Ledger';

  @override
  String get amanahAvailableLabel => 'Available';

  @override
  String get amanahDeployedLabel => 'Deployed';

  @override
  String get amanahInRecoveryLabel => 'In recovery';

  @override
  String get bannerSlide1Title => 'Barakah, built daily';

  @override
  String get bannerSlide1Sub =>
      'Consistency in giving and saving counts more than size.';

  @override
  String get bannerSlide2Title => 'Evening adhkar';

  @override
  String get bannerSlide2Sub => 'Two minutes of remembrance before Maghrib.';

  @override
  String get bannerSlide3Title => 'Today\'s sadaqah';

  @override
  String get bannerSlide3Sub =>
      'Even a small amount given consistently outweighs much.';

  @override
  String get homeOpenCampaigns => 'Open campaigns';

  @override
  String get homeOpenCampaignsEmpty => 'No campaigns are open right now.';

  @override
  String get homeSeeAll => 'See all';

  @override
  String get homeWheresMyMoney => 'Where\'s my money?';

  @override
  String get flowWallet => 'Wallet';

  @override
  String get flowSupplierPaid => 'Supplier paid';

  @override
  String get flowGoodsWithMerchant => 'Goods with merchant';

  @override
  String get flowRepayment => 'Repayment';

  @override
  String get flowProfit => 'Profit';

  @override
  String get homeGoalsTitle => 'Your goals';

  @override
  String get homeGoalsEmpty =>
      'No goals yet. Create one in Grow when it opens.';

  @override
  String get homeServicesTitle => 'Other services';

  @override
  String get serviceLearn => 'Learn';

  @override
  String get serviceZakat => 'Zakat';

  @override
  String get serviceSadaqah => 'Sadaqah';

  @override
  String get serviceWallet => 'Wallet';

  @override
  String get servicePrayer => 'Prayer';

  @override
  String get serviceQard => 'Qard e Hasanah';

  @override
  String get serviceInvite => 'Invite';

  @override
  String get serviceSoon => 'SOON';

  @override
  String serviceComingSoonBody(String service) {
    return '$service is not live yet. It arrives in a later milestone with real features, not demo content.';
  }

  @override
  String get homeNewsComing =>
      'News and Insight arrives with a real content source in a later milestone.';

  @override
  String get homeFooterDisclaimer =>
      'Capital at risk. Returns are projections, not guarantees. Ribh Investments is AAOIFI-aligned. Regulatory registration under process.';
}
