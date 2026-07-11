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
