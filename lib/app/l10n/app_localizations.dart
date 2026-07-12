import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bn'),
    Locale('en'),
  ];

  /// Application title shown in the task switcher.
  ///
  /// In en, this message translates to:
  /// **'RIBH'**
  String get appTitle;

  /// Label for the Home tab.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get tabHome;

  /// Label for the Invest tab.
  ///
  /// In en, this message translates to:
  /// **'Invest'**
  String get tabInvest;

  /// Label for the Grow tab.
  ///
  /// In en, this message translates to:
  /// **'Grow'**
  String get tabGrow;

  /// Label for the Barakah tab. Faith-adjacent brand term; Bengali rendering needs board sign-off. TODO(board)
  ///
  /// In en, this message translates to:
  /// **'Barakah'**
  String get tabBarakah;

  /// Label for the Me tab.
  ///
  /// In en, this message translates to:
  /// **'Me'**
  String get tabMe;

  /// Honest empty-shell message shown on tabs before their milestone is built. Never implies working features.
  ///
  /// In en, this message translates to:
  /// **'This area is not live yet. It arrives in an upcoming milestone with real data, not demo content.'**
  String get milestonePlaceholderBody;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @errorNotConfigured.
  ///
  /// In en, this message translates to:
  /// **'This build has no backend credentials configured, so nothing can load. Provide SUPABASE_URL and SUPABASE_PUBLISHABLE_KEY at build time.'**
  String get errorNotConfigured;

  /// No description provided for @errorNetwork.
  ///
  /// In en, this message translates to:
  /// **'Network unavailable. Check your connection and try again.'**
  String get errorNetwork;

  /// No description provided for @errorAuth.
  ///
  /// In en, this message translates to:
  /// **'You are signed out or the code was not accepted. Try again.'**
  String get errorAuth;

  /// No description provided for @errorNotVerified.
  ///
  /// In en, this message translates to:
  /// **'Identity verification is required first.'**
  String get errorNotVerified;

  /// No description provided for @errorInsufficientFunds.
  ///
  /// In en, this message translates to:
  /// **'Your available balance is not enough for this amount.'**
  String get errorInsufficientFunds;

  /// No description provided for @errorUnknown.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong: {detail}'**
  String errorUnknown(String detail);

  /// No description provided for @authTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get authTitle;

  /// No description provided for @authIntro.
  ///
  /// In en, this message translates to:
  /// **'Passwordless sign-in. We email you a one-time code; no password to remember or leak.'**
  String get authIntro;

  /// No description provided for @authEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get authEmailLabel;

  /// No description provided for @authInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get authInvalidEmail;

  /// No description provided for @authSendCode.
  ///
  /// In en, this message translates to:
  /// **'Send code'**
  String get authSendCode;

  /// No description provided for @authCodeSentTo.
  ///
  /// In en, this message translates to:
  /// **'Enter the code we sent to {email}.'**
  String authCodeSentTo(String email);

  /// No description provided for @authCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'One-time code'**
  String get authCodeLabel;

  /// No description provided for @authVerify.
  ///
  /// In en, this message translates to:
  /// **'Verify and continue'**
  String get authVerify;

  /// No description provided for @authChangeEmail.
  ///
  /// In en, this message translates to:
  /// **'Use a different email'**
  String get authChangeEmail;

  /// No description provided for @meAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get meAccount;

  /// No description provided for @meSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get meSignOut;

  /// No description provided for @meKycRow.
  ///
  /// In en, this message translates to:
  /// **'Identity and KYC'**
  String get meKycRow;

  /// No description provided for @meRiskRow.
  ///
  /// In en, this message translates to:
  /// **'Risk tier'**
  String get meRiskRow;

  /// No description provided for @meMoreComing.
  ///
  /// In en, this message translates to:
  /// **'Security and 2FA, nominee, statements, language and theme, Shariah board, and help arrive with the Me milestone.'**
  String get meMoreComing;

  /// No description provided for @kycStatusNone.
  ///
  /// In en, this message translates to:
  /// **'Not started. Required before your first deposit.'**
  String get kycStatusNone;

  /// No description provided for @kycStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Submitted. Pending verification review.'**
  String get kycStatusPending;

  /// No description provided for @kycStatusApproved.
  ///
  /// In en, this message translates to:
  /// **'Tier {tier}. Verified, source of funds on file.'**
  String kycStatusApproved(int tier);

  /// No description provided for @kycStatusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected. Please submit again.'**
  String get kycStatusRejected;

  /// No description provided for @riskTierUnset.
  ///
  /// In en, this message translates to:
  /// **'Not set. Take the 3-question quiz.'**
  String get riskTierUnset;

  /// No description provided for @riskTierShort.
  ///
  /// In en, this message translates to:
  /// **'Short: steadier, shorter cycles'**
  String get riskTierShort;

  /// No description provided for @riskTierBalanced.
  ///
  /// In en, this message translates to:
  /// **'Balanced: a sensible middle'**
  String get riskTierBalanced;

  /// No description provided for @riskTierDiversified.
  ///
  /// In en, this message translates to:
  /// **'Diversified: widest spread of contracts'**
  String get riskTierDiversified;

  /// No description provided for @kycTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify identity'**
  String get kycTitle;

  /// No description provided for @kycStepLabel.
  ///
  /// In en, this message translates to:
  /// **'Step {step} of 3'**
  String kycStepLabel(int step);

  /// No description provided for @kycStep1Body.
  ///
  /// In en, this message translates to:
  /// **'Enter your National ID number exactly as printed. Only a one-way fingerprint of the number leaves this device.'**
  String get kycStep1Body;

  /// No description provided for @kycNidLabel.
  ///
  /// In en, this message translates to:
  /// **'NID number'**
  String get kycNidLabel;

  /// No description provided for @kycNidInvalid.
  ///
  /// In en, this message translates to:
  /// **'NID numbers are 10, 13, or 17 digits.'**
  String get kycNidInvalid;

  /// No description provided for @kycContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get kycContinue;

  /// No description provided for @kycStep2Body.
  ///
  /// In en, this message translates to:
  /// **'Liveness check: a selfie matched to your NID photo. Our verification provider is not connected yet, so this step is recorded as incomplete and your submission stays in review until it is verified. Nothing is faked.'**
  String get kycStep2Body;

  /// No description provided for @kycStep2Continue.
  ///
  /// In en, this message translates to:
  /// **'Continue without liveness'**
  String get kycStep2Continue;

  /// No description provided for @kycStep3Body.
  ///
  /// In en, this message translates to:
  /// **'Source of funds, an AML requirement. Pick the main origin of the money you will invest.'**
  String get kycStep3Body;

  /// No description provided for @kycSourceSalary.
  ///
  /// In en, this message translates to:
  /// **'Salary'**
  String get kycSourceSalary;

  /// No description provided for @kycSourceBusiness.
  ///
  /// In en, this message translates to:
  /// **'Business income'**
  String get kycSourceBusiness;

  /// No description provided for @kycSourceSavings.
  ///
  /// In en, this message translates to:
  /// **'Savings'**
  String get kycSourceSavings;

  /// No description provided for @kycSourceRemittance.
  ///
  /// In en, this message translates to:
  /// **'Remittance'**
  String get kycSourceRemittance;

  /// No description provided for @kycSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit for verification'**
  String get kycSubmit;

  /// No description provided for @kycSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Submitted. Your tier upgrades only after real verification, and deposits stay locked until then.'**
  String get kycSubmitted;

  /// No description provided for @riskQuizTitle.
  ///
  /// In en, this message translates to:
  /// **'Risk tier quiz'**
  String get riskQuizTitle;

  /// No description provided for @riskQ1.
  ///
  /// In en, this message translates to:
  /// **'When do you expect to need this money?'**
  String get riskQ1;

  /// No description provided for @riskQ1A1.
  ///
  /// In en, this message translates to:
  /// **'Within a year'**
  String get riskQ1A1;

  /// No description provided for @riskQ1A2.
  ///
  /// In en, this message translates to:
  /// **'One to three years'**
  String get riskQ1A2;

  /// No description provided for @riskQ1A3.
  ///
  /// In en, this message translates to:
  /// **'Three years or more'**
  String get riskQ1A3;

  /// No description provided for @riskQ2.
  ///
  /// In en, this message translates to:
  /// **'If a campaign entered recovery, you would feel...'**
  String get riskQ2;

  /// No description provided for @riskQ2A1.
  ///
  /// In en, this message translates to:
  /// **'Very uneasy, I want the safest path'**
  String get riskQ2A1;

  /// No description provided for @riskQ2A2.
  ///
  /// In en, this message translates to:
  /// **'Concerned but patient'**
  String get riskQ2A2;

  /// No description provided for @riskQ2A3.
  ///
  /// In en, this message translates to:
  /// **'Calm, I understand trade risk'**
  String get riskQ2A3;

  /// No description provided for @riskQ3.
  ///
  /// In en, this message translates to:
  /// **'What matters most to you?'**
  String get riskQ3;

  /// No description provided for @riskQ3A1.
  ///
  /// In en, this message translates to:
  /// **'Steadier, shorter cycles'**
  String get riskQ3A1;

  /// No description provided for @riskQ3A2.
  ///
  /// In en, this message translates to:
  /// **'A sensible middle'**
  String get riskQ3A2;

  /// No description provided for @riskQ3A3.
  ///
  /// In en, this message translates to:
  /// **'Widest spread of contracts'**
  String get riskQ3A3;

  /// No description provided for @riskResultTitle.
  ///
  /// In en, this message translates to:
  /// **'Your recommended tier'**
  String get riskResultTitle;

  /// No description provided for @riskResultBody.
  ///
  /// In en, this message translates to:
  /// **'Based on your answers. This is a recommendation, not advice, and you can change it anytime. Every deployment still needs your explicit approval. Returns are never guaranteed and capital is at risk.'**
  String get riskResultBody;

  /// No description provided for @riskSave.
  ///
  /// In en, this message translates to:
  /// **'Save tier'**
  String get riskSave;

  /// No description provided for @errorGatewayNotConnected.
  ///
  /// In en, this message translates to:
  /// **'No live payment checkout is connected in this build. Nothing has been charged.'**
  String get errorGatewayNotConnected;

  /// No description provided for @homeWalletEntry.
  ///
  /// In en, this message translates to:
  /// **'Amanah Wallet'**
  String get homeWalletEntry;

  /// No description provided for @homeWalletEntrySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Balance, ledger, deposits and withdrawals.'**
  String get homeWalletEntrySubtitle;

  /// No description provided for @walletTitle.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get walletTitle;

  /// No description provided for @walletBalanceLabel.
  ///
  /// In en, this message translates to:
  /// **'Available balance'**
  String get walletBalanceLabel;

  /// No description provided for @walletBalanceDerived.
  ///
  /// In en, this message translates to:
  /// **'Derived from your append-only ledger, never stored.'**
  String get walletBalanceDerived;

  /// No description provided for @walletAddFunds.
  ///
  /// In en, this message translates to:
  /// **'Add funds'**
  String get walletAddFunds;

  /// No description provided for @walletWithdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get walletWithdraw;

  /// No description provided for @walletPendingRequests.
  ///
  /// In en, this message translates to:
  /// **'Pending requests'**
  String get walletPendingRequests;

  /// No description provided for @walletLedger.
  ///
  /// In en, this message translates to:
  /// **'Ledger'**
  String get walletLedger;

  /// No description provided for @walletLedgerEmpty.
  ///
  /// In en, this message translates to:
  /// **'No transactions yet. Your ledger starts with your first confirmed deposit.'**
  String get walletLedgerEmpty;

  /// No description provided for @txDeposit.
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get txDeposit;

  /// No description provided for @txInvestment.
  ///
  /// In en, this message translates to:
  /// **'Investment'**
  String get txInvestment;

  /// No description provided for @txDistribution.
  ///
  /// In en, this message translates to:
  /// **'Profit distribution'**
  String get txDistribution;

  /// No description provided for @txPayout.
  ///
  /// In en, this message translates to:
  /// **'Payout'**
  String get txPayout;

  /// No description provided for @txPurification.
  ///
  /// In en, this message translates to:
  /// **'Purification'**
  String get txPurification;

  /// No description provided for @txWriteDown.
  ///
  /// In en, this message translates to:
  /// **'Write-down'**
  String get txWriteDown;

  /// No description provided for @txRecovery.
  ///
  /// In en, this message translates to:
  /// **'Recovery'**
  String get txRecovery;

  /// No description provided for @txSadaqah.
  ///
  /// In en, this message translates to:
  /// **'Sadaqah'**
  String get txSadaqah;

  /// No description provided for @txZakat.
  ///
  /// In en, this message translates to:
  /// **'Zakat'**
  String get txZakat;

  /// No description provided for @methodBkash.
  ///
  /// In en, this message translates to:
  /// **'bKash'**
  String get methodBkash;

  /// No description provided for @methodNagad.
  ///
  /// In en, this message translates to:
  /// **'Nagad'**
  String get methodNagad;

  /// No description provided for @methodBank.
  ///
  /// In en, this message translates to:
  /// **'Bank transfer'**
  String get methodBank;

  /// No description provided for @requestKindDeposit.
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get requestKindDeposit;

  /// No description provided for @requestKindWithdrawal.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal'**
  String get requestKindWithdrawal;

  /// No description provided for @requestStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get requestStatusPending;

  /// No description provided for @requestStatusConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get requestStatusConfirmed;

  /// No description provided for @requestStatusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get requestStatusRejected;

  /// No description provided for @requestStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get requestStatusCancelled;

  /// No description provided for @amountLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount in taka'**
  String get amountLabel;

  /// No description provided for @invalidAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter an amount above zero, with at most two decimal places.'**
  String get invalidAmount;

  /// No description provided for @submitting.
  ///
  /// In en, this message translates to:
  /// **'Submitting...'**
  String get submitting;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @requestRecordedTitle.
  ///
  /// In en, this message translates to:
  /// **'Request recorded, pending'**
  String get requestRecordedTitle;

  /// No description provided for @depositTitle.
  ///
  /// In en, this message translates to:
  /// **'Add funds'**
  String get depositTitle;

  /// No description provided for @depositReferenceLabel.
  ///
  /// In en, this message translates to:
  /// **'Transfer reference'**
  String get depositReferenceLabel;

  /// No description provided for @depositReferenceHelp.
  ///
  /// In en, this message translates to:
  /// **'Use this reference in your bank transfer so we can match it to your request.'**
  String get depositReferenceHelp;

  /// No description provided for @depositReferenceMissing.
  ///
  /// In en, this message translates to:
  /// **'A transfer reference is required for bank deposits.'**
  String get depositReferenceMissing;

  /// No description provided for @depositOwnAccountNote.
  ///
  /// In en, this message translates to:
  /// **'Deposits must come from an account in your own name. Third-party deposits are refused at reconciliation.'**
  String get depositOwnAccountNote;

  /// No description provided for @depositSubmit.
  ///
  /// In en, this message translates to:
  /// **'Record deposit request'**
  String get depositSubmit;

  /// No description provided for @depositPendingNoCheckout.
  ///
  /// In en, this message translates to:
  /// **'{method} checkout is not connected in this build, so nothing has been charged. Your request stays pending until our team confirms a real payment. It never turns into a balance by itself.'**
  String depositPendingNoCheckout(String method);

  /// No description provided for @depositPendingCheckout.
  ///
  /// In en, this message translates to:
  /// **'Complete the checkout that opens next. Your wallet is credited only after the provider confirms the payment.'**
  String get depositPendingCheckout;

  /// No description provided for @depositPendingBank.
  ///
  /// In en, this message translates to:
  /// **'Transfer from your own account using reference {reference}. Your wallet is credited after our team reconciles the transfer; until then this request stays pending.'**
  String depositPendingBank(String reference);

  /// No description provided for @withdrawTitle.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get withdrawTitle;

  /// No description provided for @withdrawAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available for withdrawal: {amount}. Pending withdrawal requests are already excluded.'**
  String withdrawAvailable(String amount);

  /// No description provided for @withdrawTwoFaNote.
  ///
  /// In en, this message translates to:
  /// **'Withdrawals will additionally require two-factor confirmation once 2FA ships. Until the payment rail is live, transfers are sent manually after review.'**
  String get withdrawTwoFaNote;

  /// No description provided for @withdrawSubmit.
  ///
  /// In en, this message translates to:
  /// **'Record withdrawal request'**
  String get withdrawSubmit;

  /// No description provided for @withdrawPendingBody.
  ///
  /// In en, this message translates to:
  /// **'Your withdrawal request is recorded and pending review. The money leaves your balance only when the transfer is actually sent, and the ledger row appears then.'**
  String get withdrawPendingBody;

  /// No description provided for @statusOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get statusOpen;

  /// No description provided for @statusRunning.
  ///
  /// In en, this message translates to:
  /// **'Running'**
  String get statusRunning;

  /// No description provided for @statusMatured.
  ///
  /// In en, this message translates to:
  /// **'Matured'**
  String get statusMatured;

  /// No description provided for @statusRecovery.
  ///
  /// In en, this message translates to:
  /// **'In recovery'**
  String get statusRecovery;

  /// No description provided for @riskLow.
  ///
  /// In en, this message translates to:
  /// **'Low risk'**
  String get riskLow;

  /// No description provided for @riskModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate risk'**
  String get riskModerate;

  /// No description provided for @riskElevated.
  ///
  /// In en, this message translates to:
  /// **'Elevated risk'**
  String get riskElevated;

  /// No description provided for @riskDisclosure.
  ///
  /// In en, this message translates to:
  /// **'Projected, not guaranteed. Capital is at risk and returns depend on real trade outcomes.'**
  String get riskDisclosure;

  /// No description provided for @marketSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search campaigns'**
  String get marketSearchHint;

  /// No description provided for @marketFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get marketFilterAll;

  /// No description provided for @marketFilterOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get marketFilterOpen;

  /// No description provided for @marketFilterMatured.
  ///
  /// In en, this message translates to:
  /// **'Matured'**
  String get marketFilterMatured;

  /// No description provided for @marketFilterSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get marketFilterSaved;

  /// No description provided for @marketEmpty.
  ///
  /// In en, this message translates to:
  /// **'No campaigns match. Adjust the filter or search.'**
  String get marketEmpty;

  /// No description provided for @marketSaveTooltip.
  ///
  /// In en, this message translates to:
  /// **'Save to watchlist'**
  String get marketSaveTooltip;

  /// No description provided for @marketUnsaveTooltip.
  ///
  /// In en, this message translates to:
  /// **'Remove from watchlist'**
  String get marketUnsaveTooltip;

  /// No description provided for @marketFundedPercent.
  ///
  /// In en, this message translates to:
  /// **'{percent}% funded'**
  String marketFundedPercent(String percent);

  /// No description provided for @marketProjectedRate.
  ///
  /// In en, this message translates to:
  /// **'~{rate}% p.a. projected'**
  String marketProjectedRate(String rate);

  /// No description provided for @campaignDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Campaign'**
  String get campaignDetailTitle;

  /// No description provided for @campaignRaisedOfPool.
  ///
  /// In en, this message translates to:
  /// **'{raised} raised of {pool} ({percent}%)'**
  String campaignRaisedOfPool(String raised, String pool, String percent);

  /// No description provided for @campaignTermsTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms'**
  String get campaignTermsTitle;

  /// No description provided for @campaignProfitPerLac.
  ///
  /// In en, this message translates to:
  /// **'Projected profit per lac'**
  String get campaignProfitPerLac;

  /// No description provided for @campaignInvestorShare.
  ///
  /// In en, this message translates to:
  /// **'Investor share'**
  String get campaignInvestorShare;

  /// No description provided for @campaignTenureLabel.
  ///
  /// In en, this message translates to:
  /// **'Tenure'**
  String get campaignTenureLabel;

  /// No description provided for @campaignTenureMonths.
  ///
  /// In en, this message translates to:
  /// **'{months} months'**
  String campaignTenureMonths(int months);

  /// No description provided for @campaignProjectedAnnualised.
  ///
  /// In en, this message translates to:
  /// **'Projected annualised rate'**
  String get campaignProjectedAnnualised;

  /// No description provided for @campaignCalculatorTitle.
  ///
  /// In en, this message translates to:
  /// **'Profit calculator'**
  String get campaignCalculatorTitle;

  /// No description provided for @campaignCalculatorResult.
  ///
  /// In en, this message translates to:
  /// **'Projected profit: {profit} over {months} months'**
  String campaignCalculatorResult(String profit, int months);

  /// No description provided for @campaignContractBasis.
  ///
  /// In en, this message translates to:
  /// **'Contract basis'**
  String get campaignContractBasis;

  /// Shariah-facing explainer. TODO(board): board sign-off required before launch.
  ///
  /// In en, this message translates to:
  /// **'Murabaha: Ribh purchases the goods the business needs and sells them on at a disclosed markup, paid over the tenure. Profit comes from the trade, not from lending money.'**
  String get contractExplainerMurabaha;

  /// Shariah-facing explainer. TODO(board): board sign-off required before launch.
  ///
  /// In en, this message translates to:
  /// **'Musharakah: investors and the business contribute capital to a venture and share the actual profit or loss by agreed ratios. Loss is borne in proportion to capital.'**
  String get contractExplainerMusharakah;

  /// Shariah-facing explainer. TODO(board): board sign-off required before launch.
  ///
  /// In en, this message translates to:
  /// **'This campaign uses a trade-based contract reviewed for AAOIFI alignment. Details appear in the campaign documents.'**
  String get contractExplainerGeneric;

  /// No description provided for @campaignRecoveryTitle.
  ///
  /// In en, this message translates to:
  /// **'Recovery in progress'**
  String get campaignRecoveryTitle;

  /// No description provided for @campaignRecoveryBody.
  ///
  /// In en, this message translates to:
  /// **'This campaign is in recovery: repayment is behind plan and Ribh is pursuing the outstanding amount with the business. Recoveries are credited to investors\' ledgers as they are collected. Outcomes are not guaranteed.'**
  String get campaignRecoveryBody;

  /// No description provided for @campaignInvestCta.
  ///
  /// In en, this message translates to:
  /// **'Invest in this campaign'**
  String get campaignInvestCta;

  /// No description provided for @campaignNotOpen.
  ///
  /// In en, this message translates to:
  /// **'This campaign is not open for new investment.'**
  String get campaignNotOpen;

  /// No description provided for @investSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm investment'**
  String get investSheetTitle;

  /// No description provided for @investAck1.
  ///
  /// In en, this message translates to:
  /// **'I understand my capital is at risk and returns are projected, never guaranteed.'**
  String get investAck1;

  /// No description provided for @investAck2.
  ///
  /// In en, this message translates to:
  /// **'I understand my money is deployed for the full tenure and cannot be withdrawn early.'**
  String get investAck2;

  /// No description provided for @investAcksRequired.
  ///
  /// In en, this message translates to:
  /// **'Both acknowledgements are required before you can invest.'**
  String get investAcksRequired;

  /// No description provided for @investCommit.
  ///
  /// In en, this message translates to:
  /// **'Commit investment'**
  String get investCommit;

  /// No description provided for @investCommittedTitle.
  ///
  /// In en, this message translates to:
  /// **'Investment committed'**
  String get investCommittedTitle;

  /// No description provided for @investCommittedBody.
  ///
  /// In en, this message translates to:
  /// **'Your investment and its ledger entry were written together in one transaction. You can see it in your portfolio and wallet ledger now.'**
  String get investCommittedBody;

  /// No description provided for @homePortfolioTitle.
  ///
  /// In en, this message translates to:
  /// **'Portfolio'**
  String get homePortfolioTitle;

  /// No description provided for @homePortfolioEmpty.
  ///
  /// In en, this message translates to:
  /// **'No investments yet. Open campaigns are on the Invest tab.'**
  String get homePortfolioEmpty;

  /// No description provided for @portfolioInvested.
  ///
  /// In en, this message translates to:
  /// **'{amount} invested'**
  String portfolioInvested(String amount);

  /// No description provided for @amanahTitle.
  ///
  /// In en, this message translates to:
  /// **'Amanah summary'**
  String get amanahTitle;

  /// No description provided for @amanahLedgerLink.
  ///
  /// In en, this message translates to:
  /// **'Ledger'**
  String get amanahLedgerLink;

  /// No description provided for @amanahAvailableLabel.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get amanahAvailableLabel;

  /// No description provided for @amanahDeployedLabel.
  ///
  /// In en, this message translates to:
  /// **'Deployed'**
  String get amanahDeployedLabel;

  /// No description provided for @amanahInRecoveryLabel.
  ///
  /// In en, this message translates to:
  /// **'In recovery'**
  String get amanahInRecoveryLabel;

  /// Faith-adjacent copy. TODO(board): board sign-off required before launch.
  ///
  /// In en, this message translates to:
  /// **'Barakah, built daily'**
  String get bannerSlide1Title;

  /// Faith-adjacent copy. TODO(board): board sign-off required before launch.
  ///
  /// In en, this message translates to:
  /// **'Consistency in giving and saving counts more than size.'**
  String get bannerSlide1Sub;

  /// Faith-facing copy. TODO(board): board sign-off required before launch.
  ///
  /// In en, this message translates to:
  /// **'Evening adhkar'**
  String get bannerSlide2Title;

  /// Faith-facing copy. TODO(board): board sign-off required before launch.
  ///
  /// In en, this message translates to:
  /// **'Two minutes of remembrance before Maghrib.'**
  String get bannerSlide2Sub;

  /// Faith-facing copy. TODO(board): board sign-off required before launch.
  ///
  /// In en, this message translates to:
  /// **'Today\'s sadaqah'**
  String get bannerSlide3Title;

  /// Faith-facing copy. TODO(board): board sign-off required before launch.
  ///
  /// In en, this message translates to:
  /// **'Even a small amount given consistently outweighs much.'**
  String get bannerSlide3Sub;

  /// No description provided for @homeOpenCampaigns.
  ///
  /// In en, this message translates to:
  /// **'Open campaigns'**
  String get homeOpenCampaigns;

  /// No description provided for @homeOpenCampaignsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No campaigns are open right now.'**
  String get homeOpenCampaignsEmpty;

  /// No description provided for @homeSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get homeSeeAll;

  /// No description provided for @homeWheresMyMoney.
  ///
  /// In en, this message translates to:
  /// **'Where\'s my money?'**
  String get homeWheresMyMoney;

  /// No description provided for @flowWallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get flowWallet;

  /// No description provided for @flowSupplierPaid.
  ///
  /// In en, this message translates to:
  /// **'Supplier paid'**
  String get flowSupplierPaid;

  /// No description provided for @flowGoodsWithMerchant.
  ///
  /// In en, this message translates to:
  /// **'Goods with merchant'**
  String get flowGoodsWithMerchant;

  /// No description provided for @flowRepayment.
  ///
  /// In en, this message translates to:
  /// **'Repayment'**
  String get flowRepayment;

  /// No description provided for @flowProfit.
  ///
  /// In en, this message translates to:
  /// **'Profit'**
  String get flowProfit;

  /// No description provided for @homeGoalsTitle.
  ///
  /// In en, this message translates to:
  /// **'Your goals'**
  String get homeGoalsTitle;

  /// No description provided for @homeGoalsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No goals yet. Create one in Grow when it opens.'**
  String get homeGoalsEmpty;

  /// No description provided for @homeServicesTitle.
  ///
  /// In en, this message translates to:
  /// **'Other services'**
  String get homeServicesTitle;

  /// No description provided for @serviceLearn.
  ///
  /// In en, this message translates to:
  /// **'Learn'**
  String get serviceLearn;

  /// No description provided for @serviceZakat.
  ///
  /// In en, this message translates to:
  /// **'Zakat'**
  String get serviceZakat;

  /// No description provided for @serviceSadaqah.
  ///
  /// In en, this message translates to:
  /// **'Sadaqah'**
  String get serviceSadaqah;

  /// No description provided for @serviceWallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get serviceWallet;

  /// No description provided for @servicePrayer.
  ///
  /// In en, this message translates to:
  /// **'Prayer'**
  String get servicePrayer;

  /// No description provided for @serviceQard.
  ///
  /// In en, this message translates to:
  /// **'Qard e Hasanah'**
  String get serviceQard;

  /// No description provided for @serviceInvite.
  ///
  /// In en, this message translates to:
  /// **'Invite'**
  String get serviceInvite;

  /// No description provided for @serviceSoon.
  ///
  /// In en, this message translates to:
  /// **'SOON'**
  String get serviceSoon;

  /// No description provided for @serviceComingSoonBody.
  ///
  /// In en, this message translates to:
  /// **'{service} is not live yet. It arrives in a later milestone with real features, not demo content.'**
  String serviceComingSoonBody(String service);

  /// No description provided for @growFundTitle.
  ///
  /// In en, this message translates to:
  /// **'Ribh Fund'**
  String get growFundTitle;

  /// No description provided for @growFundBody.
  ///
  /// In en, this message translates to:
  /// **'Set aside funds to deploy through your chosen strategy. Every deployment still comes to your approval queue first; nothing moves silently, and nothing deploys while pending.'**
  String get growFundBody;

  /// No description provided for @growAutoInvestTitle.
  ///
  /// In en, this message translates to:
  /// **'Auto-invest strategy'**
  String get growAutoInvestTitle;

  /// No description provided for @growAutoInvestOff.
  ///
  /// In en, this message translates to:
  /// **'Off. Pick a strategy; you approve every deployment.'**
  String get growAutoInvestOff;

  /// No description provided for @growAutoInvestPaused.
  ///
  /// In en, this message translates to:
  /// **'Paused. Proposals stop until you switch it back on.'**
  String get growAutoInvestPaused;

  /// No description provided for @growAutoInvestOn.
  ///
  /// In en, this message translates to:
  /// **'{strategy} · {budget} per deployment, each one needs your approval'**
  String growAutoInvestOn(String strategy, String budget);

  /// No description provided for @strategyShortDesc.
  ///
  /// In en, this message translates to:
  /// **'Shorter trade cycles, tenure up to six months.'**
  String get strategyShortDesc;

  /// No description provided for @strategyBalancedDesc.
  ///
  /// In en, this message translates to:
  /// **'Low and moderate risk campaigns only.'**
  String get strategyBalancedDesc;

  /// No description provided for @strategyDiversifiedDesc.
  ///
  /// In en, this message translates to:
  /// **'The widest spread of contracts, including elevated risk.'**
  String get strategyDiversifiedDesc;

  /// No description provided for @autoInvestBudgetLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount per deployment in taka'**
  String get autoInvestBudgetLabel;

  /// No description provided for @autoInvestActiveLabel.
  ///
  /// In en, this message translates to:
  /// **'Strategy active'**
  String get autoInvestActiveLabel;

  /// No description provided for @autoInvestConsentNote.
  ///
  /// In en, this message translates to:
  /// **'Activating deploys nothing. Matching campaigns appear in your approval queue and each needs your explicit approval.'**
  String get autoInvestConsentNote;

  /// No description provided for @autoInvestSave.
  ///
  /// In en, this message translates to:
  /// **'Save strategy'**
  String get autoInvestSave;

  /// No description provided for @growQueueTitle.
  ///
  /// In en, this message translates to:
  /// **'Approval queue'**
  String get growQueueTitle;

  /// No description provided for @growQueueEmpty.
  ///
  /// In en, this message translates to:
  /// **'No proposals waiting. When open campaigns match your strategy they appear here, and nothing deploys without your approval.'**
  String get growQueueEmpty;

  /// No description provided for @growQueueProposal.
  ///
  /// In en, this message translates to:
  /// **'Proposes deploying {amount}'**
  String growQueueProposal(String amount);

  /// No description provided for @growQueueApprove.
  ///
  /// In en, this message translates to:
  /// **'Approve and deploy'**
  String get growQueueApprove;

  /// No description provided for @growQueueDecline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get growQueueDecline;

  /// No description provided for @approveSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Approve deployment'**
  String get approveSheetTitle;

  /// No description provided for @approveSheetBody.
  ///
  /// In en, this message translates to:
  /// **'Approving deploys {amount} into {campaign}. The investment and its ledger entry are written together in one transaction.'**
  String approveSheetBody(String amount, String campaign);

  /// No description provided for @growGoalsAdd.
  ///
  /// In en, this message translates to:
  /// **'Add goal'**
  String get growGoalsAdd;

  /// No description provided for @growGoalsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No goals yet. Add one to start tracking a target.'**
  String get growGoalsEmpty;

  /// No description provided for @goalSheetTitleNew.
  ///
  /// In en, this message translates to:
  /// **'New goal'**
  String get goalSheetTitleNew;

  /// No description provided for @goalSheetTitleEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit goal'**
  String get goalSheetTitleEdit;

  /// No description provided for @goalTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Goal name'**
  String get goalTitleLabel;

  /// No description provided for @goalTitleMissing.
  ///
  /// In en, this message translates to:
  /// **'Give the goal a name.'**
  String get goalTitleMissing;

  /// No description provided for @goalTargetLabel.
  ///
  /// In en, this message translates to:
  /// **'Target amount in taka'**
  String get goalTargetLabel;

  /// No description provided for @goalSave.
  ///
  /// In en, this message translates to:
  /// **'Save goal'**
  String get goalSave;

  /// No description provided for @goalDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete goal'**
  String get goalDelete;

  /// No description provided for @goalIconGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get goalIconGeneral;

  /// No description provided for @goalIconHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get goalIconHome;

  /// No description provided for @goalIconHajj.
  ///
  /// In en, this message translates to:
  /// **'Hajj'**
  String get goalIconHajj;

  /// No description provided for @goalIconEducation.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get goalIconEducation;

  /// No description provided for @goalIconBusiness.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get goalIconBusiness;

  /// No description provided for @goalIconFamily.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get goalIconFamily;

  /// No description provided for @investAutoInvestEntry.
  ///
  /// In en, this message translates to:
  /// **'Auto-invest'**
  String get investAutoInvestEntry;

  /// No description provided for @investAutoInvestEntrySub.
  ///
  /// In en, this message translates to:
  /// **'Strategy and approval queue'**
  String get investAutoInvestEntrySub;

  /// No description provided for @homeNewsComing.
  ///
  /// In en, this message translates to:
  /// **'News and Insight arrives with a real content source in a later milestone.'**
  String get homeNewsComing;

  /// No description provided for @homeFooterDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Capital at risk. Returns are projections, not guarantees. Ribh Investments is AAOIFI-aligned. Regulatory registration under process.'**
  String get homeFooterDisclaimer;

  /// No description provided for @errorDataSourceUnavailable.
  ///
  /// In en, this message translates to:
  /// **'The live data source behind this figure is not connected in this build, so it cannot be computed.'**
  String get errorDataSourceUnavailable;

  /// No description provided for @learnProgressLine.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} modules completed'**
  String learnProgressLine(int done, int total);

  /// TODO(board): all lesson content requires board sign-off before launch.
  ///
  /// In en, this message translates to:
  /// **'The content of this module is with the Shariah board for review and arrives before launch. Marking it read records your real progress; the text itself is a placeholder.'**
  String get learnModuleBody;

  /// No description provided for @learnMarkRead.
  ///
  /// In en, this message translates to:
  /// **'Mark as read'**
  String get learnMarkRead;

  /// No description provided for @learnReadCount.
  ///
  /// In en, this message translates to:
  /// **'Read {count} times'**
  String learnReadCount(int count);

  /// No description provided for @learnCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get learnCompleted;

  /// Faith-facing copy. TODO(board): board sign-off required before launch.
  ///
  /// In en, this message translates to:
  /// **'Zakat cleanses wealth'**
  String get zakatBanner1Title;

  /// Faith-facing copy. TODO(board): board sign-off required before launch.
  ///
  /// In en, this message translates to:
  /// **'An obligation on wealth above the Nisab for a lunar year.'**
  String get zakatBanner1Sub;

  /// Faith-facing copy. TODO(board): board sign-off required before launch.
  ///
  /// In en, this message translates to:
  /// **'The silver standard'**
  String get zakatBanner2Title;

  /// Faith-facing copy. TODO(board): board sign-off required before launch.
  ///
  /// In en, this message translates to:
  /// **'Ribh uses the silver Nisab so Zakat reaches more people.'**
  String get zakatBanner2Sub;

  /// No description provided for @zakatBanner3Title.
  ///
  /// In en, this message translates to:
  /// **'No fee, ever'**
  String get zakatBanner3Title;

  /// No description provided for @zakatBanner3Sub.
  ///
  /// In en, this message translates to:
  /// **'Every taka of Zakat goes to the project. Ribh takes nothing out of it.'**
  String get zakatBanner3Sub;

  /// No description provided for @zakatCalcTitle.
  ///
  /// In en, this message translates to:
  /// **'Zakat calculator'**
  String get zakatCalcTitle;

  /// No description provided for @zakatCashLabel.
  ///
  /// In en, this message translates to:
  /// **'Cash and bank balances'**
  String get zakatCashLabel;

  /// No description provided for @zakatGoldLabel.
  ///
  /// In en, this message translates to:
  /// **'Gold value'**
  String get zakatGoldLabel;

  /// No description provided for @zakatSilverLabel.
  ///
  /// In en, this message translates to:
  /// **'Silver value'**
  String get zakatSilverLabel;

  /// No description provided for @zakatBusinessLabel.
  ///
  /// In en, this message translates to:
  /// **'Business assets'**
  String get zakatBusinessLabel;

  /// No description provided for @zakatDebtsLabel.
  ///
  /// In en, this message translates to:
  /// **'Debts to deduct'**
  String get zakatDebtsLabel;

  /// No description provided for @zakatTotalLine.
  ///
  /// In en, this message translates to:
  /// **'Zakatable wealth: {amount}'**
  String zakatTotalLine(String amount);

  /// No description provided for @zakatDueLine.
  ///
  /// In en, this message translates to:
  /// **'Zakat due at 2.5%: {amount}'**
  String zakatDueLine(String amount);

  /// TODO(board): the calculation basis, silver standard, and rate need board sign-off.
  ///
  /// In en, this message translates to:
  /// **'Calculation basis pending Shariah board sign-off. This is arithmetic, not a ruling.'**
  String get zakatGuidanceNote;

  /// No description provided for @zakatNisabTitle.
  ///
  /// In en, this message translates to:
  /// **'Nisab status'**
  String get zakatNisabTitle;

  /// No description provided for @zakatNisabUnavailable.
  ///
  /// In en, this message translates to:
  /// **'The live silver price source is not connected in this build, so the Nisab threshold cannot be computed. Nothing is estimated in its place.'**
  String get zakatNisabUnavailable;

  /// No description provided for @zakatNisabAbove.
  ///
  /// In en, this message translates to:
  /// **'Your zakatable wealth is above the silver Nisab ({threshold}). Zakat applies.'**
  String zakatNisabAbove(String threshold);

  /// No description provided for @zakatNisabBelow.
  ///
  /// In en, this message translates to:
  /// **'Your zakatable wealth is below the silver Nisab ({threshold}). Zakat is not due.'**
  String zakatNisabBelow(String threshold);

  /// No description provided for @welfareProjectsTitle.
  ///
  /// In en, this message translates to:
  /// **'Ribh Welfare projects'**
  String get welfareProjectsTitle;

  /// No description provided for @projectProgress.
  ///
  /// In en, this message translates to:
  /// **'{raised} raised of {target}'**
  String projectProgress(String raised, String target);

  /// No description provided for @giveZakatCta.
  ///
  /// In en, this message translates to:
  /// **'Give Zakat'**
  String get giveZakatCta;

  /// No description provided for @giveSadaqahCta.
  ///
  /// In en, this message translates to:
  /// **'Give Sadaqah'**
  String get giveSadaqahCta;

  /// No description provided for @giveSheetProject.
  ///
  /// In en, this message translates to:
  /// **'Project'**
  String get giveSheetProject;

  /// No description provided for @giveNoFeeNote.
  ///
  /// In en, this message translates to:
  /// **'The full amount reaches the project from your wallet balance. Ribh takes no fee out of Zakat.'**
  String get giveNoFeeNote;

  /// No description provided for @giveRecordedTitle.
  ///
  /// In en, this message translates to:
  /// **'Given'**
  String get giveRecordedTitle;

  /// No description provided for @giveRecordedBody.
  ///
  /// In en, this message translates to:
  /// **'Your contribution and its ledger entry were written together. The project total updated with the full amount.'**
  String get giveRecordedBody;

  /// No description provided for @sadaqahMonthLine.
  ///
  /// In en, this message translates to:
  /// **'This month: {amount}'**
  String sadaqahMonthLine(String amount);

  /// No description provided for @sadaqahLifetimeLine.
  ///
  /// In en, this message translates to:
  /// **'Lifetime: {amount}'**
  String sadaqahLifetimeLine(String amount);

  /// No description provided for @sadaqahHabitTitle.
  ///
  /// In en, this message translates to:
  /// **'Giving habit'**
  String get sadaqahHabitTitle;

  /// No description provided for @sadaqahHabitCount.
  ///
  /// In en, this message translates to:
  /// **'{days} of 30 days'**
  String sadaqahHabitCount(int days);

  /// No description provided for @forestTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Forest'**
  String get forestTitle;

  /// No description provided for @forestCount.
  ///
  /// In en, this message translates to:
  /// **'{count} trees'**
  String forestCount(int count);

  /// No description provided for @treePledged.
  ///
  /// In en, this message translates to:
  /// **'Pledged'**
  String get treePledged;

  /// No description provided for @treePlanted.
  ///
  /// In en, this message translates to:
  /// **'Planted'**
  String get treePlanted;

  /// Faith-facing education copy. TODO(board): board sign-off required before launch.
  ///
  /// In en, this message translates to:
  /// **'Qard e Hasanah is an interest-free loan for those in need. Ribh is building it so repayment is always at par: you repay exactly what you borrowed, nothing more, ever.'**
  String get qardBody;

  /// No description provided for @qardComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Honestly not open yet. No lending exists in this version.'**
  String get qardComingSoon;

  /// No description provided for @qardNotify.
  ///
  /// In en, this message translates to:
  /// **'Notify me when it opens'**
  String get qardNotify;

  /// No description provided for @qardRegistered.
  ///
  /// In en, this message translates to:
  /// **'You are on the list. We will tell you when Qard opens.'**
  String get qardRegistered;

  /// No description provided for @inviteYourLink.
  ///
  /// In en, this message translates to:
  /// **'Your invite link'**
  String get inviteYourLink;

  /// No description provided for @inviteCopy.
  ///
  /// In en, this message translates to:
  /// **'Copy link'**
  String get inviteCopy;

  /// No description provided for @inviteCopied.
  ///
  /// In en, this message translates to:
  /// **'Link copied.'**
  String get inviteCopied;

  /// No description provided for @inviteShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get inviteShare;

  /// No description provided for @invitePointsTitle.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get invitePointsTitle;

  /// No description provided for @invitePointsLine.
  ///
  /// In en, this message translates to:
  /// **'{points} points · {joined} joined, {verified} verified'**
  String invitePointsLine(int points, int joined, int verified);

  /// No description provided for @invitePointsRule.
  ///
  /// In en, this message translates to:
  /// **'Points come from sign-up and verification only, never from investing. Rewards are trees, never cash or fee credit.'**
  String get invitePointsRule;

  /// No description provided for @inviteRedeem.
  ///
  /// In en, this message translates to:
  /// **'Plant a tree (50 points)'**
  String get inviteRedeem;

  /// No description provided for @inviteRedeemedBody.
  ///
  /// In en, this message translates to:
  /// **'Tree pledged. It is planted at the next drive, and its drive and district are recorded when that happens.'**
  String get inviteRedeemedBody;

  /// No description provided for @walletPerformanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Performance'**
  String get walletPerformanceTitle;

  /// No description provided for @walletPerformanceNote.
  ///
  /// In en, this message translates to:
  /// **'Cumulative invested and profit by month, derived from your ledger. There is no daily volatility to show.'**
  String get walletPerformanceNote;

  /// No description provided for @walletPerformanceEmpty.
  ///
  /// In en, this message translates to:
  /// **'The chart appears once your ledger has monthly history.'**
  String get walletPerformanceEmpty;

  /// No description provided for @walletChartInvested.
  ///
  /// In en, this message translates to:
  /// **'Invested'**
  String get walletChartInvested;

  /// No description provided for @walletChartProfit.
  ///
  /// In en, this message translates to:
  /// **'Profit'**
  String get walletChartProfit;

  /// No description provided for @errorLocationUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Location is off or permission was refused, so prayer times and qibla cannot be computed for where you are. Nothing is estimated in their place.'**
  String get errorLocationUnavailable;

  /// No description provided for @prayerLocationLine.
  ///
  /// In en, this message translates to:
  /// **'For your location ({lat}, {lng})'**
  String prayerLocationLine(String lat, String lng);

  /// No description provided for @salahFajr.
  ///
  /// In en, this message translates to:
  /// **'Fajr'**
  String get salahFajr;

  /// No description provided for @salahDhuhr.
  ///
  /// In en, this message translates to:
  /// **'Dhuhr'**
  String get salahDhuhr;

  /// No description provided for @salahAsr.
  ///
  /// In en, this message translates to:
  /// **'Asr'**
  String get salahAsr;

  /// No description provided for @salahMaghrib.
  ///
  /// In en, this message translates to:
  /// **'Maghrib'**
  String get salahMaghrib;

  /// No description provided for @salahIsha.
  ///
  /// In en, this message translates to:
  /// **'Isha'**
  String get salahIsha;

  /// No description provided for @prayerNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get prayerNext;

  /// TODO(board): the calculation method needs board sign-off before launch.
  ///
  /// In en, this message translates to:
  /// **'Karachi calculation method. Method choice pending Shariah board sign-off.'**
  String get prayerMethodNote;

  /// No description provided for @qiblaTitle.
  ///
  /// In en, this message translates to:
  /// **'Qibla'**
  String get qiblaTitle;

  /// No description provided for @qiblaBearingLine.
  ///
  /// In en, this message translates to:
  /// **'{degrees}° from north'**
  String qiblaBearingLine(String degrees);

  /// No description provided for @qiblaFallbackNote.
  ///
  /// In en, this message translates to:
  /// **'No compass reading is available on this device, so the dial is not rotating. Use the bearing above with a physical compass.'**
  String get qiblaFallbackNote;

  /// No description provided for @prayerAlarmsTitle.
  ///
  /// In en, this message translates to:
  /// **'Salah alarms'**
  String get prayerAlarmsTitle;

  /// No description provided for @prayerAlarmPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Notification permission was refused, so the alarm stays off.'**
  String get prayerAlarmPermissionDenied;

  /// Worship-adjacent notification copy. TODO(board): board sign-off required before launch.
  ///
  /// In en, this message translates to:
  /// **'Time for {salah}'**
  String salahAlarmTitle(String salah);

  /// Worship-adjacent notification copy. TODO(board): board sign-off required before launch.
  ///
  /// In en, this message translates to:
  /// **'The prayer time you asked to be reminded of has arrived.'**
  String get salahAlarmBody;

  /// No description provided for @barakahScoreTitle.
  ///
  /// In en, this message translates to:
  /// **'Barakah score · {score}'**
  String barakahScoreTitle(int score);

  /// No description provided for @barakahScoreHonesty.
  ///
  /// In en, this message translates to:
  /// **'This reflects your app habits only: giving, your own check-ins, and counter use. It never measures worship itself, and it is never shown to anyone else.'**
  String get barakahScoreHonesty;

  /// Faith-facing. TODO(board): the adhkar set and target need board sign-off.
  ///
  /// In en, this message translates to:
  /// **'Adhkar and tasbih'**
  String get tasbihTitle;

  /// No description provided for @tasbihProgress.
  ///
  /// In en, this message translates to:
  /// **'{count} of {target} today'**
  String tasbihProgress(int count, int target);

  /// Faith-facing. TODO(board): board sign-off required before launch.
  ///
  /// In en, this message translates to:
  /// **'Daily reflection'**
  String get dailyItemTitle;

  /// No description provided for @dailyItemFavourite.
  ///
  /// In en, this message translates to:
  /// **'Save to favourites'**
  String get dailyItemFavourite;

  /// No description provided for @dailyItemBoardGated.
  ///
  /// In en, this message translates to:
  /// **'The text appears here after Shariah board review. Saving to favourites already works and survives the review.'**
  String get dailyItemBoardGated;

  /// Citation only, no translation. TODO(board): text and selection need board sign-off.
  ///
  /// In en, this message translates to:
  /// **'Qur\'an 2:261, on charity multiplied'**
  String get dailyItemQuran2261;

  /// Citation only, no translation. TODO(board): text, attribution, and selection need board sign-off.
  ///
  /// In en, this message translates to:
  /// **'Hadith: the most beloved deeds are the most consistent'**
  String get dailyItemHadithConsistency;

  /// Citation only, no translation. TODO(board): text and selection need board sign-off.
  ///
  /// In en, this message translates to:
  /// **'Qur\'an 13:28, on hearts finding rest'**
  String get dailyItemQuran1328;

  /// No description provided for @prayerCheckTitle.
  ///
  /// In en, this message translates to:
  /// **'Prayer check-in'**
  String get prayerCheckTitle;

  /// No description provided for @prayerCheckStreak.
  ///
  /// In en, this message translates to:
  /// **'Current streak: {days} days'**
  String prayerCheckStreak(int days);

  /// No description provided for @prayerCheckHonesty.
  ///
  /// In en, this message translates to:
  /// **'Self-reported, only for your own consistency. A missed day simply starts again; nothing is lost and nobody sees this.'**
  String get prayerCheckHonesty;

  /// No description provided for @prayerCheckCta.
  ///
  /// In en, this message translates to:
  /// **'I prayed today'**
  String get prayerCheckCta;

  /// No description provided for @prayerCheckDone.
  ///
  /// In en, this message translates to:
  /// **'Checked in for today.'**
  String get prayerCheckDone;

  /// No description provided for @barakahLearnNext.
  ///
  /// In en, this message translates to:
  /// **'Continue learning'**
  String get barakahLearnNext;

  /// No description provided for @barakahSadaqahNudge.
  ///
  /// In en, this message translates to:
  /// **'Today\'s sadaqah'**
  String get barakahSadaqahNudge;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['bn', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn':
      return AppLocalizationsBn();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
