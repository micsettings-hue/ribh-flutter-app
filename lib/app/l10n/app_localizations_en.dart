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
  String get emptyTitle => 'Nothing here yet';

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
  String get authOr => 'or';

  @override
  String get authGoogle => 'Continue with Google';

  @override
  String get mePrefTitle => 'Preferences';

  @override
  String get mePrefLanguage => 'Language';

  @override
  String get mePrefTheme => 'Theme';

  @override
  String get langSystem => 'System default';

  @override
  String get langEnglish => 'English';

  @override
  String get langBengali => 'বাংলা (Bengali)';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get meAboutTitle => 'About and support';

  @override
  String get meShariahBoard => 'Shariah board';

  @override
  String get meHelp => 'Help and disputes';

  @override
  String get meComingTitle => 'Coming soon';

  @override
  String get meSecurity2fa => 'Security and 2FA';

  @override
  String get meNominee => 'Nominee';

  @override
  String get meStatements => 'Statements';

  @override
  String get meComingNote =>
      'These sections need real backend integration and are honestly marked as not yet available, never faked.';

  @override
  String get boardIntro =>
      'Ribh\'s Shariah board reviews and approves the faith-facing structure of the product. Approval by the board chair is required before any Shariah-facing feature launches.';

  @override
  String get boardChairName => 'Abdullah Jubair';

  @override
  String get boardChairRole => 'Board chair';

  @override
  String get boardMemberPlaceholder => 'Placeholder seat';

  @override
  String get boardMemberRole => 'Board member';

  @override
  String get boardPlaceholderBadge => 'PLACEHOLDER';

  @override
  String get boardComplianceNote =>
      'Two board seats are placeholders. Real, consenting scholars must be appointed before launch; they are shown here as placeholders and are not real appointments.';

  @override
  String get helpIntro =>
      'Need help or want to raise a dispute? Here is how to reach us and what to expect.';

  @override
  String get helpContactTitle => 'Contact';

  @override
  String get helpContactBody =>
      'Email our support team; we aim to reply within two business days.';

  @override
  String get helpCopyEmail => 'Copy email';

  @override
  String get helpEmailCopied => 'Support email copied.';

  @override
  String get helpDisputeTitle => 'Disputes';

  @override
  String get helpDisputeBody =>
      'If you believe a transaction or campaign outcome is wrong, contact support with the details and any reference numbers. Every money movement is recorded in your append-only ledger, so it can always be traced.';

  @override
  String get helpDisputeSteps =>
      '1. Email support with the ledger reference. 2. We investigate against the ledger. 3. You receive a written outcome. Regulatory escalation paths apply once registration is complete.';

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
  String get growFundTitle => 'Ribh Fund';

  @override
  String get growFundBody =>
      'Set aside funds to deploy through your chosen strategy. Every deployment still comes to your approval queue first; nothing moves silently, and nothing deploys while pending.';

  @override
  String get growAutoInvestTitle => 'Auto-invest strategy';

  @override
  String get growAutoInvestOff =>
      'Off. Pick a strategy; you approve every deployment.';

  @override
  String get growAutoInvestPaused =>
      'Paused. Proposals stop until you switch it back on.';

  @override
  String growAutoInvestOn(String strategy, String budget) {
    return '$strategy · $budget per deployment, each one needs your approval';
  }

  @override
  String get strategyShortDesc =>
      'Shorter trade cycles, tenure up to six months.';

  @override
  String get strategyBalancedDesc => 'Low and moderate risk campaigns only.';

  @override
  String get strategyDiversifiedDesc =>
      'The widest spread of contracts, including elevated risk.';

  @override
  String get autoInvestBudgetLabel => 'Amount per deployment in taka';

  @override
  String get autoInvestActiveLabel => 'Strategy active';

  @override
  String get autoInvestConsentNote =>
      'Activating deploys nothing. Matching campaigns appear in your approval queue and each needs your explicit approval.';

  @override
  String get autoInvestSave => 'Save strategy';

  @override
  String get growQueueTitle => 'Approval queue';

  @override
  String get growQueueEmpty =>
      'No proposals waiting. When open campaigns match your strategy they appear here, and nothing deploys without your approval.';

  @override
  String growQueueProposal(String amount) {
    return 'Proposes deploying $amount';
  }

  @override
  String get growQueueApprove => 'Approve and deploy';

  @override
  String get growQueueDecline => 'Decline';

  @override
  String get approveSheetTitle => 'Approve deployment';

  @override
  String approveSheetBody(String amount, String campaign) {
    return 'Approving deploys $amount into $campaign. The investment and its ledger entry are written together in one transaction.';
  }

  @override
  String get growGoalsAdd => 'Add goal';

  @override
  String get growGoalsEmpty =>
      'No goals yet. Add one to start tracking a target.';

  @override
  String get goalSheetTitleNew => 'New goal';

  @override
  String get goalSheetTitleEdit => 'Edit goal';

  @override
  String get goalTitleLabel => 'Goal name';

  @override
  String get goalTitleMissing => 'Give the goal a name.';

  @override
  String get goalTargetLabel => 'Target amount in taka';

  @override
  String get goalSave => 'Save goal';

  @override
  String get goalDelete => 'Delete goal';

  @override
  String get goalIconGeneral => 'General';

  @override
  String get goalIconHome => 'Home';

  @override
  String get goalIconHajj => 'Hajj';

  @override
  String get goalIconEducation => 'Education';

  @override
  String get goalIconBusiness => 'Business';

  @override
  String get goalIconFamily => 'Family';

  @override
  String get investAutoInvestEntry => 'Auto-invest';

  @override
  String get investAutoInvestEntrySub => 'Strategy and approval queue';

  @override
  String get homeNewsTitle => 'News and Insight';

  @override
  String get homeNewsEmpty =>
      'No news yet. Updates and insights appear here as they are published.';

  @override
  String get homeNewsComing =>
      'News and Insight arrives with a real content source in a later milestone.';

  @override
  String get homeFooterDisclaimer =>
      'Capital at risk. Returns are projections, not guarantees. Ribh Investments is AAOIFI-aligned. Regulatory registration under process.';

  @override
  String get errorDataSourceUnavailable =>
      'The live data source behind this figure is not connected in this build, so it cannot be computed.';

  @override
  String learnProgressLine(int done, int total) {
    return '$done of $total modules completed';
  }

  @override
  String get learnModuleBody =>
      'The content of this module is with the Shariah board for review and arrives before launch. Marking it read records your real progress; the text itself is a placeholder.';

  @override
  String get learnMarkRead => 'Mark as read';

  @override
  String learnReadCount(int count) {
    return 'Read $count times';
  }

  @override
  String get learnCompleted => 'Completed';

  @override
  String get zakatBanner1Title => 'Zakat cleanses wealth';

  @override
  String get zakatBanner1Sub =>
      'An obligation on wealth above the Nisab for a lunar year.';

  @override
  String get zakatBanner2Title => 'The silver standard';

  @override
  String get zakatBanner2Sub =>
      'Ribh uses the silver Nisab so Zakat reaches more people.';

  @override
  String get zakatBanner3Title => 'No fee, ever';

  @override
  String get zakatBanner3Sub =>
      'Every taka of Zakat goes to the project. Ribh takes nothing out of it.';

  @override
  String get zakatCalcTitle => 'Zakat calculator';

  @override
  String get zakatCashLabel => 'Cash and bank balances';

  @override
  String get zakatGoldLabel => 'Gold value';

  @override
  String get zakatSilverLabel => 'Silver value';

  @override
  String get zakatBusinessLabel => 'Business assets';

  @override
  String get zakatDebtsLabel => 'Debts to deduct';

  @override
  String zakatTotalLine(String amount) {
    return 'Zakatable wealth: $amount';
  }

  @override
  String zakatDueLine(String amount) {
    return 'Zakat due at 2.5%: $amount';
  }

  @override
  String get zakatGuidanceNote =>
      'Calculation basis pending Shariah board sign-off. This is arithmetic, not a ruling.';

  @override
  String get zakatNisabTitle => 'Nisab status';

  @override
  String get zakatNisabUnavailable =>
      'The live silver price source is not connected in this build, so the Nisab threshold cannot be computed. Nothing is estimated in its place.';

  @override
  String zakatNisabAbove(String threshold) {
    return 'Your zakatable wealth is above the silver Nisab ($threshold). Zakat applies.';
  }

  @override
  String zakatNisabBelow(String threshold) {
    return 'Your zakatable wealth is below the silver Nisab ($threshold). Zakat is not due.';
  }

  @override
  String get welfareProjectsTitle => 'Ribh Welfare projects';

  @override
  String projectProgress(String raised, String target) {
    return '$raised raised of $target';
  }

  @override
  String get giveZakatCta => 'Give Zakat';

  @override
  String get giveSadaqahCta => 'Give Sadaqah';

  @override
  String get giveSheetProject => 'Project';

  @override
  String get giveNoFeeNote =>
      'The full amount reaches the project from your wallet balance. Ribh takes no fee out of Zakat.';

  @override
  String get giveRecordedTitle => 'Given';

  @override
  String get giveRecordedBody =>
      'Your contribution and its ledger entry were written together. The project total updated with the full amount.';

  @override
  String sadaqahMonthLine(String amount) {
    return 'This month: $amount';
  }

  @override
  String sadaqahLifetimeLine(String amount) {
    return 'Lifetime: $amount';
  }

  @override
  String get sadaqahHabitTitle => 'Giving habit';

  @override
  String sadaqahHabitCount(int days) {
    return '$days of 30 days';
  }

  @override
  String get forestTitle => 'Your Forest';

  @override
  String forestCount(int count) {
    return '$count trees';
  }

  @override
  String get treePledged => 'Pledged';

  @override
  String get treePlanted => 'Planted';

  @override
  String get qardBody =>
      'Qard e Hasanah is an interest-free loan for those in need. Ribh is building it so repayment is always at par: you repay exactly what you borrowed, nothing more, ever.';

  @override
  String get qardComingSoon =>
      'Honestly not open yet. No lending exists in this version.';

  @override
  String get qardNotify => 'Notify me when it opens';

  @override
  String get qardRegistered =>
      'You are on the list. We will tell you when Qard opens.';

  @override
  String get inviteYourLink => 'Your invite link';

  @override
  String get inviteCopy => 'Copy link';

  @override
  String get inviteCopied => 'Link copied.';

  @override
  String get inviteShare => 'Share';

  @override
  String get invitePointsTitle => 'Points';

  @override
  String invitePointsLine(int points, int joined, int verified) {
    return '$points points · $joined joined, $verified verified';
  }

  @override
  String get invitePointsRule =>
      'Points come from sign-up and verification only, never from investing. Rewards are trees, never cash or fee credit.';

  @override
  String get inviteRedeem => 'Plant a tree (50 points)';

  @override
  String get inviteRedeemedBody =>
      'Tree pledged. It is planted at the next drive, and its drive and district are recorded when that happens.';

  @override
  String get walletPerformanceTitle => 'Performance';

  @override
  String get walletPerformanceNote =>
      'Cumulative invested and profit by month, derived from your ledger. There is no daily volatility to show.';

  @override
  String get walletPerformanceEmpty =>
      'The chart appears once your ledger has monthly history.';

  @override
  String get walletChartInvested => 'Invested';

  @override
  String get walletChartProfit => 'Profit';

  @override
  String get errorLocationUnavailable =>
      'Location is off or permission was refused, so prayer times and qibla cannot be computed for where you are. Nothing is estimated in their place.';

  @override
  String prayerLocationLine(String lat, String lng) {
    return 'For your location ($lat, $lng)';
  }

  @override
  String get salahFajr => 'Fajr';

  @override
  String get salahDhuhr => 'Dhuhr';

  @override
  String get salahAsr => 'Asr';

  @override
  String get salahMaghrib => 'Maghrib';

  @override
  String get salahIsha => 'Isha';

  @override
  String get prayerNext => 'Next';

  @override
  String get prayerMethodNote =>
      'Karachi calculation method. Method choice pending Shariah board sign-off.';

  @override
  String get qiblaTitle => 'Qibla';

  @override
  String qiblaBearingLine(String degrees) {
    return '$degrees° from north';
  }

  @override
  String get qiblaFallbackNote =>
      'No compass reading is available on this device, so the dial is not rotating. Use the bearing above with a physical compass.';

  @override
  String get prayerAlarmsTitle => 'Salah alarms';

  @override
  String get prayerAlarmPermissionDenied =>
      'Notification permission was refused, so the alarm stays off.';

  @override
  String salahAlarmTitle(String salah) {
    return 'Time for $salah';
  }

  @override
  String get salahAlarmBody =>
      'The prayer time you asked to be reminded of has arrived.';

  @override
  String barakahScoreTitle(int score) {
    return 'Barakah score · $score';
  }

  @override
  String get barakahScoreHonesty =>
      'This reflects your app habits only: giving, your own check-ins, and counter use. It never measures worship itself, and it is never shown to anyone else.';

  @override
  String get tasbihTitle => 'Adhkar and tasbih';

  @override
  String tasbihProgress(int count, int target) {
    return '$count of $target today';
  }

  @override
  String get dailyItemTitle => 'Daily reflection';

  @override
  String get dailyItemFavourite => 'Save to favourites';

  @override
  String get dailyItemBoardGated =>
      'The text appears here after Shariah board review. Saving to favourites already works and survives the review.';

  @override
  String get dailyItemQuran2261 => 'Qur\'an 2:261, on charity multiplied';

  @override
  String get dailyItemHadithConsistency =>
      'Hadith: the most beloved deeds are the most consistent';

  @override
  String get dailyItemQuran1328 => 'Qur\'an 13:28, on hearts finding rest';

  @override
  String get prayerCheckTitle => 'Prayer check-in';

  @override
  String prayerCheckStreak(int days) {
    return 'Current streak: $days days';
  }

  @override
  String get prayerCheckHonesty =>
      'Self-reported, only for your own consistency. A missed day simply starts again; nothing is lost and nobody sees this.';

  @override
  String get prayerCheckCta => 'I prayed today';

  @override
  String get prayerCheckDone => 'Checked in for today.';

  @override
  String get barakahLearnNext => 'Continue learning';

  @override
  String get barakahSadaqahNudge => 'Today\'s sadaqah';
}
