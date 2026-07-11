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
}
