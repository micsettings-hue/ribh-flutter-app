// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appTitle => 'রিব';

  @override
  String get tabHome => 'হোম';

  @override
  String get tabInvest => 'বিনিয়োগ';

  @override
  String get tabGrow => 'বৃদ্ধি';

  @override
  String get tabBarakah => 'বারাকাহ';

  @override
  String get tabMe => 'আমি';

  @override
  String get milestonePlaceholderBody =>
      'এই অংশটি এখনও চালু হয়নি। পরবর্তী মাইলফলকে এটি প্রকৃত ডেটাসহ আসবে, কোনো ডেমো কনটেন্ট নয়।';

  @override
  String get retry => 'আবার চেষ্টা করুন';

  @override
  String get emptyTitle => 'এখানে এখনও কিছু নেই';

  @override
  String get cancel => 'বাতিল';

  @override
  String get errorNotConfigured =>
      'এই বিল্ডে ব্যাকএন্ডের কোনো credential নেই, তাই কিছু লোড হবে না। বিল্ডের সময় SUPABASE_URL এবং SUPABASE_PUBLISHABLE_KEY দিন।';

  @override
  String get errorNetwork =>
      'নেটওয়ার্ক পাওয়া যাচ্ছে না। সংযোগ পরীক্ষা করে আবার চেষ্টা করুন।';

  @override
  String get errorAuth =>
      'আপনি সাইন আউট হয়ে আছেন অথবা কোডটি গৃহীত হয়নি। আবার চেষ্টা করুন।';

  @override
  String get errorNotVerified => 'আগে পরিচয় যাচাই সম্পন্ন করা প্রয়োজন।';

  @override
  String get errorInsufficientFunds =>
      'এই পরিমাণের জন্য আপনার ব্যালেন্স যথেষ্ট নয়।';

  @override
  String errorUnknown(String detail) {
    return 'কিছু একটা ভুল হয়েছে: $detail';
  }

  @override
  String get authTitle => 'সাইন ইন';

  @override
  String get authIntro =>
      'পাসওয়ার্ডবিহীন সাইন ইন। আমরা আপনার ইমেইলে একবার ব্যবহারযোগ্য কোড পাঠাই; মনে রাখার বা ফাঁস হওয়ার মতো কোনো পাসওয়ার্ড নেই।';

  @override
  String get authEmailLabel => 'ইমেইল';

  @override
  String get authInvalidEmail => 'সঠিক ইমেইল ঠিকানা লিখুন।';

  @override
  String get authSendCode => 'কোড পাঠান';

  @override
  String authCodeSentTo(String email) {
    return '$email ঠিকানায় পাঠানো কোডটি লিখুন।';
  }

  @override
  String get authCodeLabel => 'একবার ব্যবহারযোগ্য কোড';

  @override
  String get authVerify => 'যাচাই করে এগিয়ে যান';

  @override
  String get authChangeEmail => 'অন্য ইমেইল ব্যবহার করুন';

  @override
  String get authOr => 'অথবা';

  @override
  String get authGoogle => 'Google দিয়ে চালিয়ে যান';

  @override
  String get mePrefTitle => 'পছন্দসমূহ';

  @override
  String get mePrefLanguage => 'ভাষা';

  @override
  String get mePrefTheme => 'থিম';

  @override
  String get langSystem => 'সিস্টেম ডিফল্ট';

  @override
  String get langEnglish => 'English';

  @override
  String get langBengali => 'বাংলা';

  @override
  String get themeSystem => 'সিস্টেম';

  @override
  String get themeLight => 'লাইট';

  @override
  String get themeDark => 'ডার্ক';

  @override
  String get meAboutTitle => 'সম্পর্কে ও সহায়তা';

  @override
  String get meShariahBoard => 'শরিয়াহ বোর্ড';

  @override
  String get meHelp => 'সহায়তা ও বিরোধ';

  @override
  String get meComingTitle => 'শীঘ্রই আসছে';

  @override
  String get meSecurity2fa => 'নিরাপত্তা ও 2FA';

  @override
  String get meNominee => 'নমিনি';

  @override
  String get meStatements => 'স্টেটমেন্ট';

  @override
  String get meComingNote =>
      'এই অংশগুলোর জন্য প্রকৃত ব্যাকএন্ড সংযোগ প্রয়োজন এবং সততার সাথে \'এখনও নেই\' হিসেবে চিহ্নিত, কখনও বানোয়াট নয়।';

  @override
  String get boardIntro =>
      'রিবহের শরিয়াহ বোর্ড পণ্যের ধর্মসংশ্লিষ্ট কাঠামো পর্যালোচনা ও অনুমোদন করে। যেকোনো শরিয়াহ-সংশ্লিষ্ট ফিচার চালুর আগে বোর্ড চেয়ারের অনুমোদন আবশ্যক।';

  @override
  String get boardChairName => 'আবদুল্লাহ জুবায়ের';

  @override
  String get boardChairRole => 'বোর্ড চেয়ার';

  @override
  String get boardMemberPlaceholder => 'প্লেসহোল্ডার আসন';

  @override
  String get boardMemberRole => 'বোর্ড সদস্য';

  @override
  String get boardPlaceholderBadge => 'প্লেসহোল্ডার';

  @override
  String get boardComplianceNote =>
      'দুটি বোর্ড আসন প্লেসহোল্ডার। লঞ্চের আগে প্রকৃত সম্মত আলেমদের নিয়োগ দিতে হবে; এখানে এগুলো প্লেসহোল্ডার হিসেবে দেখানো হয়েছে, প্রকৃত নিয়োগ নয়।';

  @override
  String get helpIntro =>
      'সহায়তা প্রয়োজন বা বিরোধ জানাতে চান? কীভাবে আমাদের কাছে পৌঁছাবেন ও কী আশা করবেন তা এখানে।';

  @override
  String get helpContactTitle => 'যোগাযোগ';

  @override
  String get helpContactBody =>
      'আমাদের সহায়তা দলকে ইমেইল করুন; আমরা দুই কর্মদিবসের মধ্যে উত্তর দেওয়ার চেষ্টা করি।';

  @override
  String get helpCopyEmail => 'ইমেইল কপি করুন';

  @override
  String get helpEmailCopied => 'সহায়তা ইমেইল কপি হয়েছে।';

  @override
  String get helpDisputeTitle => 'বিরোধ';

  @override
  String get helpDisputeBody =>
      'কোনো লেনদেন বা ক্যাম্পেইনের ফলাফল ভুল মনে হলে বিস্তারিত ও রেফারেন্স নম্বরসহ সহায়তায় যোগাযোগ করুন। প্রতিটি অর্থ চলাচল আপনার কেবল-সংযোজন লেজারে লিপিবদ্ধ, তাই সবসময় তা যাচাই করা যায়।';

  @override
  String get helpDisputeSteps =>
      '১. লেজার রেফারেন্সসহ সহায়তায় ইমেইল করুন। ২. আমরা লেজারের সাথে মিলিয়ে তদন্ত করি। ৩. আপনি লিখিত ফলাফল পাবেন। নিবন্ধন সম্পন্ন হলে নিয়ন্ত্রক এস্কেলেশন পথ প্রযোজ্য হবে।';

  @override
  String get meAccount => 'অ্যাকাউন্ট';

  @override
  String get meSignOut => 'সাইন আউট';

  @override
  String get meKycRow => 'পরিচয় ও KYC';

  @override
  String get meRiskRow => 'ঝুঁকি স্তর';

  @override
  String get meMoreComing =>
      'নিরাপত্তা ও 2FA, নমিনি, স্টেটমেন্ট, ভাষা ও থিম, শরিয়াহ বোর্ড এবং সহায়তা Me মাইলফলকে আসবে।';

  @override
  String get kycStatusNone => 'শুরু হয়নি। প্রথম জমার আগে আবশ্যক।';

  @override
  String get kycStatusPending =>
      'জমা দেওয়া হয়েছে। যাচাই পর্যালোচনার অপেক্ষায়।';

  @override
  String kycStatusApproved(int tier) {
    return 'স্তর $tier। যাচাইকৃত, অর্থের উৎস নথিভুক্ত।';
  }

  @override
  String get kycStatusRejected => 'প্রত্যাখ্যাত। অনুগ্রহ করে আবার জমা দিন।';

  @override
  String get riskTierUnset => 'নির্ধারিত নয়। ৩টি প্রশ্নের কুইজ দিন।';

  @override
  String get riskTierShort => 'সংক্ষিপ্ত: স্থিতিশীল, ছোট চক্র';

  @override
  String get riskTierBalanced => 'ভারসাম্যপূর্ণ: মাঝামাঝি পথ';

  @override
  String get riskTierDiversified => 'বৈচিত্র্যময়: চুক্তির বিস্তৃত পরিসর';

  @override
  String get kycTitle => 'পরিচয় যাচাই করুন';

  @override
  String kycStepLabel(int step) {
    return 'ধাপ $step এর মধ্যে ৩';
  }

  @override
  String get kycStep1Body =>
      'আপনার জাতীয় পরিচয়পত্রের নম্বর হুবহু লিখুন। নম্বরটির শুধু একমুখী ফিঙ্গারপ্রিন্ট এই ডিভাইস থেকে যায়।';

  @override
  String get kycNidLabel => 'NID নম্বর';

  @override
  String get kycNidInvalid => 'NID নম্বর ১০, ১৩ বা ১৭ সংখ্যার হয়।';

  @override
  String get kycContinue => 'এগিয়ে যান';

  @override
  String get kycStep2Body =>
      'লাইভনেস যাচাই: আপনার NID ছবির সাথে সেলফি মেলানো হয়। আমাদের যাচাই প্রদানকারী এখনও সংযুক্ত হয়নি, তাই এই ধাপ অসম্পূর্ণ হিসেবে লিপিবদ্ধ হবে এবং যাচাই না হওয়া পর্যন্ত আপনার জমা পর্যালোচনায় থাকবে। কিছুই বানোয়াট নয়।';

  @override
  String get kycStep2Continue => 'লাইভনেস ছাড়া এগিয়ে যান';

  @override
  String get kycStep3Body =>
      'অর্থের উৎস, একটি AML বাধ্যবাধকতা। আপনি যে অর্থ বিনিয়োগ করবেন তার প্রধান উৎস বেছে নিন।';

  @override
  String get kycSourceSalary => 'বেতন';

  @override
  String get kycSourceBusiness => 'ব্যবসায়িক আয়';

  @override
  String get kycSourceSavings => 'সঞ্চয়';

  @override
  String get kycSourceRemittance => 'রেমিট্যান্স';

  @override
  String get kycSubmit => 'যাচাইয়ের জন্য জমা দিন';

  @override
  String get kycSubmitted =>
      'জমা দেওয়া হয়েছে। প্রকৃত যাচাইয়ের পরই আপনার স্তর বাড়বে, ততক্ষণ জমা বন্ধ থাকবে।';

  @override
  String get riskQuizTitle => 'ঝুঁকি স্তরের কুইজ';

  @override
  String get riskQ1 => 'এই অর্থ কখন প্রয়োজন হতে পারে বলে আশা করছেন?';

  @override
  String get riskQ1A1 => 'এক বছরের মধ্যে';

  @override
  String get riskQ1A2 => 'এক থেকে তিন বছরে';

  @override
  String get riskQ1A3 => 'তিন বছর বা তার বেশি';

  @override
  String get riskQ2 => 'কোনো ক্যাম্পেইন রিকভারিতে গেলে আপনার অনুভূতি হবে...';

  @override
  String get riskQ2A1 => 'খুব অস্বস্তি, আমি নিরাপদতম পথ চাই';

  @override
  String get riskQ2A2 => 'চিন্তিত কিন্তু ধৈর্যশীল';

  @override
  String get riskQ2A3 => 'শান্ত, আমি বাণিজ্য ঝুঁকি বুঝি';

  @override
  String get riskQ3 => 'আপনার কাছে সবচেয়ে গুরুত্বপূর্ণ কী?';

  @override
  String get riskQ3A1 => 'স্থিতিশীল, ছোট চক্র';

  @override
  String get riskQ3A2 => 'মাঝামাঝি একটি পথ';

  @override
  String get riskQ3A3 => 'চুক্তির বিস্তৃত পরিসর';

  @override
  String get riskResultTitle => 'আপনার জন্য প্রস্তাবিত স্তর';

  @override
  String get riskResultBody =>
      'আপনার উত্তরের ভিত্তিতে। এটি একটি প্রস্তাব, কোনো পরামর্শ নয়, এবং আপনি যেকোনো সময় বদলাতে পারেন। প্রতিটি বিনিয়োগে এখনও আপনার সুস্পষ্ট অনুমোদন লাগবে। মুনাফার কোনো নিশ্চয়তা নেই এবং মূলধন ঝুঁকির মধ্যে থাকে।';

  @override
  String get riskSave => 'স্তর সংরক্ষণ করুন';

  @override
  String get errorGatewayNotConnected =>
      'এই বিল্ডে কোনো সরাসরি পেমেন্ট চেকআউট সংযুক্ত নেই। কোনো টাকা কাটা হয়নি।';

  @override
  String get homeWalletEntry => 'আমানাহ ওয়ালেট';

  @override
  String get homeWalletEntrySubtitle => 'ব্যালেন্স, লেজার, জমা ও উত্তোলন।';

  @override
  String get walletTitle => 'ওয়ালেট';

  @override
  String get walletBalanceLabel => 'উপলব্ধ ব্যালেন্স';

  @override
  String get walletBalanceDerived =>
      'আপনার কেবল-সংযোজন লেজার থেকে হিসাব করা, কখনও সংরক্ষিত নয়।';

  @override
  String get walletAddFunds => 'টাকা যোগ করুন';

  @override
  String get walletWithdraw => 'উত্তোলন';

  @override
  String get walletPendingRequests => 'অপেক্ষমাণ অনুরোধ';

  @override
  String get walletLedger => 'লেজার';

  @override
  String get walletLedgerEmpty =>
      'এখনও কোনো লেনদেন নেই। আপনার প্রথম নিশ্চিত জমা দিয়ে লেজার শুরু হবে।';

  @override
  String get txDeposit => 'জমা';

  @override
  String get txInvestment => 'বিনিয়োগ';

  @override
  String get txDistribution => 'মুনাফা বণ্টন';

  @override
  String get txPayout => 'পেআউট';

  @override
  String get txPurification => 'পরিশুদ্ধকরণ';

  @override
  String get txWriteDown => 'অবলোপন';

  @override
  String get txRecovery => 'রিকভারি';

  @override
  String get txSadaqah => 'সাদাকাহ';

  @override
  String get txZakat => 'যাকাত';

  @override
  String get methodBkash => 'বিকাশ';

  @override
  String get methodNagad => 'নগদ';

  @override
  String get methodBank => 'ব্যাংক ট্রান্সফার';

  @override
  String get requestKindDeposit => 'জমা';

  @override
  String get requestKindWithdrawal => 'উত্তোলন';

  @override
  String get requestStatusPending => 'অপেক্ষমাণ';

  @override
  String get requestStatusConfirmed => 'নিশ্চিত';

  @override
  String get requestStatusRejected => 'প্রত্যাখ্যাত';

  @override
  String get requestStatusCancelled => 'বাতিল';

  @override
  String get amountLabel => 'টাকার পরিমাণ';

  @override
  String get invalidAmount =>
      'শূন্যের বেশি পরিমাণ লিখুন, দশমিকের পরে সর্বোচ্চ দুই সংখ্যা।';

  @override
  String get submitting => 'জমা হচ্ছে...';

  @override
  String get done => 'সম্পন্ন';

  @override
  String get requestRecordedTitle => 'অনুরোধ লিপিবদ্ধ, অপেক্ষমাণ';

  @override
  String get depositTitle => 'টাকা যোগ করুন';

  @override
  String get depositReferenceLabel => 'ট্রান্সফার রেফারেন্স';

  @override
  String get depositReferenceHelp =>
      'ব্যাংক ট্রান্সফারে এই রেফারেন্সটি ব্যবহার করুন যাতে আমরা আপনার অনুরোধের সাথে মেলাতে পারি।';

  @override
  String get depositReferenceMissing =>
      'ব্যাংক জমার জন্য ট্রান্সফার রেফারেন্স আবশ্যক।';

  @override
  String get depositOwnAccountNote =>
      'জমা অবশ্যই আপনার নিজের নামের অ্যাকাউন্ট থেকে আসতে হবে। তৃতীয় পক্ষের জমা মেলানোর সময় ফেরত দেওয়া হয়।';

  @override
  String get depositSubmit => 'জমার অনুরোধ লিপিবদ্ধ করুন';

  @override
  String depositPendingNoCheckout(String method) {
    return '$method চেকআউট এই বিল্ডে সংযুক্ত নেই, তাই কোনো টাকা কাটা হয়নি। আমাদের দল প্রকৃত পেমেন্ট নিশ্চিত না করা পর্যন্ত আপনার অনুরোধ অপেক্ষমাণ থাকবে। এটি নিজে থেকে কখনও ব্যালেন্সে পরিণত হয় না।';
  }

  @override
  String get depositPendingCheckout =>
      'পরবর্তী চেকআউটটি সম্পন্ন করুন। প্রদানকারী পেমেন্ট নিশ্চিত করার পরই আপনার ওয়ালেটে টাকা যোগ হয়।';

  @override
  String depositPendingBank(String reference) {
    return 'আপনার নিজের অ্যাকাউন্ট থেকে $reference রেফারেন্স দিয়ে ট্রান্সফার করুন। আমাদের দল ট্রান্সফার মেলানোর পর আপনার ওয়ালেটে টাকা যোগ হবে; ততক্ষণ এই অনুরোধ অপেক্ষমাণ থাকবে।';
  }

  @override
  String get withdrawTitle => 'উত্তোলন';

  @override
  String withdrawAvailable(String amount) {
    return 'উত্তোলনের জন্য উপলব্ধ: $amount। অপেক্ষমাণ উত্তোলনের অনুরোধ আগেই বাদ দেওয়া হয়েছে।';
  }

  @override
  String get withdrawTwoFaNote =>
      '2FA চালু হলে উত্তোলনে অতিরিক্ত দ্বি-স্তর নিশ্চিতকরণ লাগবে। পেমেন্ট রেল চালু না হওয়া পর্যন্ত পর্যালোচনার পর ট্রান্সফার ম্যানুয়ালি পাঠানো হয়।';

  @override
  String get withdrawSubmit => 'উত্তোলনের অনুরোধ লিপিবদ্ধ করুন';

  @override
  String get withdrawPendingBody =>
      'আপনার উত্তোলনের অনুরোধ লিপিবদ্ধ হয়েছে এবং পর্যালোচনায় আছে। ট্রান্সফার প্রকৃতপক্ষে পাঠানো হলেই ব্যালেন্স থেকে টাকা যাবে এবং তখনই লেজারে সারি দেখা যাবে।';

  @override
  String get statusOpen => 'খোলা';

  @override
  String get statusRunning => 'চলমান';

  @override
  String get statusMatured => 'মেয়াদপূর্ণ';

  @override
  String get statusRecovery => 'রিকভারিতে';

  @override
  String get riskLow => 'কম ঝুঁকি';

  @override
  String get riskModerate => 'মাঝারি ঝুঁকি';

  @override
  String get riskElevated => 'উচ্চ ঝুঁকি';

  @override
  String get riskDisclosure =>
      'প্রক্ষেপিত, নিশ্চিত নয়। মূলধন ঝুঁকির মধ্যে থাকে এবং মুনাফা প্রকৃত বাণিজ্যের ফলাফলের ওপর নির্ভর করে।';

  @override
  String get marketSearchHint => 'ক্যাম্পেইন খুঁজুন';

  @override
  String get marketFilterAll => 'সব';

  @override
  String get marketFilterOpen => 'খোলা';

  @override
  String get marketFilterMatured => 'মেয়াদপূর্ণ';

  @override
  String get marketFilterSaved => 'সংরক্ষিত';

  @override
  String get marketEmpty =>
      'কোনো ক্যাম্পেইন মেলেনি। ফিল্টার বা অনুসন্ধান বদলে দেখুন।';

  @override
  String get marketSaveTooltip => 'ওয়াচলিস্টে রাখুন';

  @override
  String get marketUnsaveTooltip => 'ওয়াচলিস্ট থেকে সরান';

  @override
  String marketFundedPercent(String percent) {
    return '$percent% সংগৃহীত';
  }

  @override
  String marketProjectedRate(String rate) {
    return '~$rate% বার্ষিক, প্রক্ষেপিত';
  }

  @override
  String get campaignDetailTitle => 'ক্যাম্পেইন';

  @override
  String campaignRaisedOfPool(String raised, String pool, String percent) {
    return '$pool-এর মধ্যে $raised সংগৃহীত ($percent%)';
  }

  @override
  String get campaignTermsTitle => 'শর্তাবলি';

  @override
  String get campaignProfitPerLac => 'প্রতি লাখে প্রক্ষেপিত মুনাফা';

  @override
  String get campaignInvestorShare => 'বিনিয়োগকারীর অংশ';

  @override
  String get campaignTenureLabel => 'মেয়াদ';

  @override
  String campaignTenureMonths(int months) {
    return '$months মাস';
  }

  @override
  String get campaignProjectedAnnualised => 'প্রক্ষেপিত বার্ষিক হার';

  @override
  String get campaignCalculatorTitle => 'মুনাফা ক্যালকুলেটর';

  @override
  String campaignCalculatorResult(String profit, int months) {
    return 'প্রক্ষেপিত মুনাফা: $months মাসে $profit';
  }

  @override
  String get campaignContractBasis => 'চুক্তির ভিত্তি';

  @override
  String get contractExplainerMurabaha =>
      'মুরাবাহা: ব্যবসার প্রয়োজনীয় পণ্য রিবহ কিনে ঘোষিত মুনাফাসহ বিক্রি করে, যা মেয়াদজুড়ে পরিশোধ হয়। মুনাফা আসে বাণিজ্য থেকে, অর্থ ধার দেওয়া থেকে নয়।';

  @override
  String get contractExplainerMusharakah =>
      'মুশারাকাহ: বিনিয়োগকারী ও ব্যবসা একটি উদ্যোগে মূলধন দেয় এবং সম্মত অনুপাতে প্রকৃত লাভ-ক্ষতি ভাগ করে। ক্ষতি মূলধনের অনুপাতে বহন করা হয়।';

  @override
  String get contractExplainerGeneric =>
      'এই ক্যাম্পেইন AAOIFI-সামঞ্জস্যের জন্য পর্যালোচিত একটি বাণিজ্যভিত্তিক চুক্তি ব্যবহার করে। বিস্তারিত ক্যাম্পেইনের নথিতে আছে।';

  @override
  String get campaignRecoveryTitle => 'রিকভারি চলছে';

  @override
  String get campaignRecoveryBody =>
      'এই ক্যাম্পেইন রিকভারিতে আছে: পরিশোধ পরিকল্পনার চেয়ে পিছিয়ে এবং রিবহ ব্যবসার কাছ থেকে বকেয়া আদায়ে কাজ করছে। আদায় হওয়া অর্থ বিনিয়োগকারীদের লেজারে জমা হয়। ফলাফলের কোনো নিশ্চয়তা নেই।';

  @override
  String get campaignInvestCta => 'এই ক্যাম্পেইনে বিনিয়োগ করুন';

  @override
  String get campaignNotOpen => 'এই ক্যাম্পেইন নতুন বিনিয়োগের জন্য খোলা নেই।';

  @override
  String get investSheetTitle => 'বিনিয়োগ নিশ্চিত করুন';

  @override
  String get investAck1 =>
      'আমি বুঝি আমার মূলধন ঝুঁকির মধ্যে এবং মুনাফা প্রক্ষেপিত, কখনও নিশ্চিত নয়।';

  @override
  String get investAck2 =>
      'আমি বুঝি আমার অর্থ পুরো মেয়াদের জন্য বিনিয়োজিত থাকবে এবং আগে তোলা যাবে না।';

  @override
  String get investAcksRequired => 'বিনিয়োগের আগে দুটি স্বীকৃতিই আবশ্যক।';

  @override
  String get investCommit => 'বিনিয়োগ সম্পন্ন করুন';

  @override
  String get investCommittedTitle => 'বিনিয়োগ সম্পন্ন';

  @override
  String get investCommittedBody =>
      'আপনার বিনিয়োগ ও তার লেজার এন্ট্রি এক লেনদেনে একসাথে লেখা হয়েছে। এখনই পোর্টফোলিও ও ওয়ালেট লেজারে দেখতে পাবেন।';

  @override
  String get homePortfolioTitle => 'পোর্টফোলিও';

  @override
  String get homePortfolioEmpty =>
      'এখনও কোনো বিনিয়োগ নেই। খোলা ক্যাম্পেইন Invest ট্যাবে আছে।';

  @override
  String portfolioInvested(String amount) {
    return '$amount বিনিয়োজিত';
  }

  @override
  String get amanahTitle => 'আমানাহ সারসংক্ষেপ';

  @override
  String get amanahLedgerLink => 'লেজার';

  @override
  String get amanahAvailableLabel => 'উপলব্ধ';

  @override
  String get amanahDeployedLabel => 'বিনিয়োজিত';

  @override
  String get amanahInRecoveryLabel => 'রিকভারিতে';

  @override
  String get bannerSlide1Title => 'বারাকাহ, প্রতিদিন গড়ে ওঠে';

  @override
  String get bannerSlide1Sub =>
      'দেওয়া ও সঞ্চয়ে ধারাবাহিকতা পরিমাণের চেয়ে বেশি গুরুত্বপূর্ণ।';

  @override
  String get bannerSlide2Title => 'সন্ধ্যার আযকার';

  @override
  String get bannerSlide2Sub => 'মাগরিবের আগে দুই মিনিটের যিকর।';

  @override
  String get bannerSlide3Title => 'আজকের সাদাকাহ';

  @override
  String get bannerSlide3Sub => 'নিয়মিত দেওয়া অল্পও অনেক কিছুর চেয়ে ভারী।';

  @override
  String get homeOpenCampaigns => 'খোলা ক্যাম্পেইন';

  @override
  String get homeOpenCampaignsEmpty => 'এই মুহূর্তে কোনো ক্যাম্পেইন খোলা নেই।';

  @override
  String get homeSeeAll => 'সব দেখুন';

  @override
  String get homeWheresMyMoney => 'আমার টাকা কোথায়?';

  @override
  String get flowWallet => 'ওয়ালেট';

  @override
  String get flowSupplierPaid => 'সরবরাহকারীকে পরিশোধ';

  @override
  String get flowGoodsWithMerchant => 'পণ্য ব্যবসায়ীর কাছে';

  @override
  String get flowRepayment => 'পরিশোধ';

  @override
  String get flowProfit => 'মুনাফা';

  @override
  String get homeGoalsTitle => 'আপনার লক্ষ্য';

  @override
  String get homeGoalsEmpty =>
      'এখনও কোনো লক্ষ্য নেই। Grow খুললে একটি তৈরি করুন।';

  @override
  String get homeServicesTitle => 'অন্যান্য সেবা';

  @override
  String get serviceLearn => 'শিখুন';

  @override
  String get serviceZakat => 'যাকাত';

  @override
  String get serviceSadaqah => 'সাদাকাহ';

  @override
  String get serviceWallet => 'ওয়ালেট';

  @override
  String get servicePrayer => 'নামায';

  @override
  String get serviceQard => 'কর্জে হাসানাহ';

  @override
  String get serviceInvite => 'আমন্ত্রণ';

  @override
  String get serviceSoon => 'শীঘ্রই';

  @override
  String serviceComingSoonBody(String service) {
    return '$service এখনও চালু হয়নি। এটি পরের কোনো মাইলফলকে প্রকৃত ফিচারসহ আসবে, ডেমো কনটেন্ট নয়।';
  }

  @override
  String get growFundTitle => 'রিবহ ফান্ড';

  @override
  String get growFundBody =>
      'আপনার বাছাই করা রণনীতিতে বিনিয়োগের জন্য অর্থ আলাদা করুন। প্রতিটি বিনিয়োগ আগে আপনার অনুমোদন সারিতে আসে; কিছুই নীরবে যায় না, এবং অপেক্ষমাণ অবস্থায় কিছুই বিনিয়োজিত হয় না।';

  @override
  String get growAutoInvestTitle => 'অটো-ইনভেস্ট রণনীতি';

  @override
  String get growAutoInvestOff =>
      'বন্ধ। রণনীতি বাছুন; প্রতিটি বিনিয়োগ আপনি অনুমোদন করবেন।';

  @override
  String get growAutoInvestPaused =>
      'বিরতিতে। আবার চালু না করা পর্যন্ত প্রস্তাব আসবে না।';

  @override
  String growAutoInvestOn(String strategy, String budget) {
    return '$strategy · প্রতি বিনিয়োগে $budget, প্রতিটিতে আপনার অনুমোদন লাগবে';
  }

  @override
  String get strategyShortDesc => 'ছোট বাণিজ্য চক্র, মেয়াদ সর্বোচ্চ ছয় মাস।';

  @override
  String get strategyBalancedDesc => 'শুধু কম ও মাঝারি ঝুঁকির ক্যাম্পেইন।';

  @override
  String get strategyDiversifiedDesc =>
      'চুক্তির বিস্তৃততম পরিসর, উচ্চ ঝুঁকিসহ।';

  @override
  String get autoInvestBudgetLabel => 'প্রতি বিনিয়োগের পরিমাণ, টাকায়';

  @override
  String get autoInvestActiveLabel => 'রণনীতি সক্রিয়';

  @override
  String get autoInvestConsentNote =>
      'সক্রিয় করলেই কিছু বিনিয়োজিত হয় না। মিলে যাওয়া ক্যাম্পেইন আপনার অনুমোদন সারিতে আসে এবং প্রতিটিতে আপনার সুস্পষ্ট অনুমোদন লাগে।';

  @override
  String get autoInvestSave => 'রণনীতি সংরক্ষণ করুন';

  @override
  String get growQueueTitle => 'অনুমোদন সারি';

  @override
  String get growQueueEmpty =>
      'কোনো প্রস্তাব অপেক্ষায় নেই। খোলা ক্যাম্পেইন আপনার রণনীতির সাথে মিললে এখানে আসবে, এবং আপনার অনুমোদন ছাড়া কিছুই বিনিয়োজিত হয় না।';

  @override
  String growQueueProposal(String amount) {
    return '$amount বিনিয়োগের প্রস্তাব';
  }

  @override
  String get growQueueApprove => 'অনুমোদন ও বিনিয়োগ';

  @override
  String get growQueueDecline => 'প্রত্যাখ্যান';

  @override
  String get approveSheetTitle => 'বিনিয়োগ অনুমোদন করুন';

  @override
  String approveSheetBody(String amount, String campaign) {
    return 'অনুমোদন করলে $campaign-এ $amount বিনিয়োজিত হবে। বিনিয়োগ ও তার লেজার এন্ট্রি এক লেনদেনে একসাথে লেখা হয়।';
  }

  @override
  String get growGoalsAdd => 'লক্ষ্য যোগ করুন';

  @override
  String get growGoalsEmpty =>
      'এখনও কোনো লক্ষ্য নেই। একটি লক্ষ্য যোগ করে শুরু করুন।';

  @override
  String get goalSheetTitleNew => 'নতুন লক্ষ্য';

  @override
  String get goalSheetTitleEdit => 'লক্ষ্য সম্পাদনা';

  @override
  String get goalTitleLabel => 'লক্ষ্যের নাম';

  @override
  String get goalTitleMissing => 'লক্ষ্যের একটি নাম দিন।';

  @override
  String get goalTargetLabel => 'লক্ষ্যমাত্রা, টাকায়';

  @override
  String get goalSave => 'লক্ষ্য সংরক্ষণ করুন';

  @override
  String get goalDelete => 'লক্ষ্য মুছুন';

  @override
  String get goalIconGeneral => 'সাধারণ';

  @override
  String get goalIconHome => 'বাড়ি';

  @override
  String get goalIconHajj => 'হজ';

  @override
  String get goalIconEducation => 'শিক্ষা';

  @override
  String get goalIconBusiness => 'ব্যবসা';

  @override
  String get goalIconFamily => 'পরিবার';

  @override
  String get investAutoInvestEntry => 'অটো-ইনভেস্ট';

  @override
  String get investAutoInvestEntrySub => 'রণনীতি ও অনুমোদন সারি';

  @override
  String get homeNewsTitle => 'নিউজ ও ইনসাইট';

  @override
  String get homeNewsEmpty =>
      'এখনও কোনো খবর নেই। প্রকাশিত হলে আপডেট ও ইনসাইট এখানে দেখা যাবে।';

  @override
  String get homeNewsComing =>
      'নিউজ ও ইনসাইট পরের কোনো মাইলফলকে প্রকৃত কনটেন্ট উৎসসহ আসবে।';

  @override
  String get homeFooterDisclaimer =>
      'মূলধন ঝুঁকির মধ্যে। মুনাফা প্রক্ষেপণ, নিশ্চয়তা নয়। রিবহ ইনভেস্টমেন্টস AAOIFI-সামঞ্জস্যপূর্ণ। নিয়ন্ত্রক নিবন্ধন প্রক্রিয়াধীন।';

  @override
  String get errorDataSourceUnavailable =>
      'এই সংখ্যার পেছনের লাইভ ডেটা উৎস এই বিল্ডে সংযুক্ত নেই, তাই এটি হিসাব করা যাচ্ছে না।';

  @override
  String learnProgressLine(int done, int total) {
    return '$totalটির মধ্যে $doneটি মডিউল সম্পন্ন';
  }

  @override
  String get learnModuleBody =>
      'এই মডিউলের বিষয়বস্তু শরিয়াহ বোর্ডের পর্যালোচনায় আছে এবং লঞ্চের আগে আসবে। পড়া হিসেবে চিহ্নিত করলে আপনার প্রকৃত অগ্রগতি লিপিবদ্ধ হয়; লেখাটি নিজে একটি প্লেসহোল্ডার।';

  @override
  String get learnMarkRead => 'পড়া হয়েছে চিহ্নিত করুন';

  @override
  String learnReadCount(int count) {
    return '$count বার পড়া হয়েছে';
  }

  @override
  String get learnCompleted => 'সম্পন্ন';

  @override
  String get zakatBanner1Title => 'যাকাত সম্পদ পরিশুদ্ধ করে';

  @override
  String get zakatBanner1Sub =>
      'চান্দ্র বছর ধরে নিসাবের ওপরে থাকা সম্পদের ওপর ফরজ।';

  @override
  String get zakatBanner2Title => 'রুপার মানদণ্ড';

  @override
  String get zakatBanner2Sub =>
      'রিবহ রুপার নিসাব ব্যবহার করে, যাতে যাকাত বেশি মানুষের কাছে পৌঁছায়।';

  @override
  String get zakatBanner3Title => 'কোনো ফি নেই, কখনও না';

  @override
  String get zakatBanner3Sub =>
      'যাকাতের প্রতিটি টাকা প্রকল্পে যায়। রিবহ এর থেকে কিছুই নেয় না।';

  @override
  String get zakatCalcTitle => 'যাকাত ক্যালকুলেটর';

  @override
  String get zakatCashLabel => 'নগদ ও ব্যাংক ব্যালেন্স';

  @override
  String get zakatGoldLabel => 'সোনার মূল্য';

  @override
  String get zakatSilverLabel => 'রুপার মূল্য';

  @override
  String get zakatBusinessLabel => 'ব্যবসায়িক সম্পদ';

  @override
  String get zakatDebtsLabel => 'বাদ দেওয়ার ঋণ';

  @override
  String zakatTotalLine(String amount) {
    return 'যাকাতযোগ্য সম্পদ: $amount';
  }

  @override
  String zakatDueLine(String amount) {
    return '২.৫% হারে প্রদেয় যাকাত: $amount';
  }

  @override
  String get zakatGuidanceNote =>
      'হিসাবের ভিত্তি শরিয়াহ বোর্ডের অনুমোদনের অপেক্ষায়। এটি গণনা, কোনো ফতোয়া নয়।';

  @override
  String get zakatNisabTitle => 'নিসাবের অবস্থা';

  @override
  String get zakatNisabUnavailable =>
      'লাইভ রুপার দামের উৎস এই বিল্ডে সংযুক্ত নেই, তাই নিসাব সীমা হিসাব করা যাচ্ছে না। এর জায়গায় কোনো অনুমান দেখানো হয় না।';

  @override
  String zakatNisabAbove(String threshold) {
    return 'আপনার যাকাতযোগ্য সম্পদ রুপার নিসাবের ($threshold) ওপরে। যাকাত প্রযোজ্য।';
  }

  @override
  String zakatNisabBelow(String threshold) {
    return 'আপনার যাকাতযোগ্য সম্পদ রুপার নিসাবের ($threshold) নিচে। যাকাত প্রদেয় নয়।';
  }

  @override
  String get welfareProjectsTitle => 'রিবহ ওয়েলফেয়ার প্রকল্প';

  @override
  String projectProgress(String raised, String target) {
    return '$target-এর মধ্যে $raised সংগৃহীত';
  }

  @override
  String get giveZakatCta => 'যাকাত দিন';

  @override
  String get giveSadaqahCta => 'সাদাকাহ দিন';

  @override
  String get giveSheetProject => 'প্রকল্প';

  @override
  String get giveNoFeeNote =>
      'আপনার ওয়ালেট ব্যালেন্স থেকে পুরো অর্থ প্রকল্পে পৌঁছায়। রিবহ যাকাত থেকে কোনো ফি নেয় না।';

  @override
  String get giveRecordedTitle => 'দেওয়া হয়েছে';

  @override
  String get giveRecordedBody =>
      'আপনার দান ও তার লেজার এন্ট্রি একসাথে লেখা হয়েছে। প্রকল্পের মোট অঙ্কে পুরো অর্থ যোগ হয়েছে।';

  @override
  String sadaqahMonthLine(String amount) {
    return 'এই মাসে: $amount';
  }

  @override
  String sadaqahLifetimeLine(String amount) {
    return 'সর্বমোট: $amount';
  }

  @override
  String get sadaqahHabitTitle => 'দানের অভ্যাস';

  @override
  String sadaqahHabitCount(int days) {
    return '৩০ দিনের মধ্যে $days দিন';
  }

  @override
  String get forestTitle => 'আপনার বন';

  @override
  String forestCount(int count) {
    return '$countটি গাছ';
  }

  @override
  String get treePledged => 'প্রতিশ্রুত';

  @override
  String get treePlanted => 'রোপিত';

  @override
  String get qardBody =>
      'কর্জে হাসানাহ হলো প্রয়োজনে থাকা মানুষের জন্য সুদমুক্ত ঋণ। রিবহ এটি এমনভাবে গড়ছে যাতে পরিশোধ সবসময় সমান অঙ্কে হয়: যা ধার নিয়েছেন ঠিক তা-ই ফেরত দেবেন, এর বেশি কখনও নয়।';

  @override
  String get qardComingSoon =>
      'সততার সাথে বলছি: এখনও খোলেনি। এই সংস্করণে কোনো ঋণ নেই।';

  @override
  String get qardNotify => 'খুললে আমাকে জানান';

  @override
  String get qardRegistered => 'আপনি তালিকায় আছেন। কর্জ খুললে আমরা জানাব।';

  @override
  String get inviteYourLink => 'আপনার আমন্ত্রণ লিংক';

  @override
  String get inviteCopy => 'লিংক কপি করুন';

  @override
  String get inviteCopied => 'লিংক কপি হয়েছে।';

  @override
  String get inviteShare => 'শেয়ার';

  @override
  String get invitePointsTitle => 'পয়েন্ট';

  @override
  String invitePointsLine(int points, int joined, int verified) {
    return '$points পয়েন্ট · $joined জন যুক্ত, $verified জন যাচাইকৃত';
  }

  @override
  String get invitePointsRule =>
      'পয়েন্ট আসে শুধু সাইন-আপ ও যাচাই থেকে, বিনিয়োগ থেকে কখনও নয়। পুরস্কার গাছ, কখনও নগদ বা ফি ছাড় নয়।';

  @override
  String get inviteRedeem => 'একটি গাছ লাগান (৫০ পয়েন্ট)';

  @override
  String get inviteRedeemedBody =>
      'গাছ প্রতিশ্রুত হয়েছে। পরের ড্রাইভে এটি রোপণ হবে, এবং তখন তার ড্রাইভ ও জেলা লিপিবদ্ধ হবে।';

  @override
  String get walletPerformanceTitle => 'পারফরম্যান্স';

  @override
  String get walletPerformanceNote =>
      'মাসভিত্তিক ক্রমযোজিত বিনিয়োগ ও মুনাফা, আপনার লেজার থেকে হিসাব করা। দেখানোর মতো কোনো দৈনিক ওঠানামা নেই।';

  @override
  String get walletPerformanceEmpty =>
      'লেজারে মাসভিত্তিক ইতিহাস জমলে চার্টটি দেখা যাবে।';

  @override
  String get walletChartInvested => 'বিনিয়োজিত';

  @override
  String get walletChartProfit => 'মুনাফা';

  @override
  String get errorLocationUnavailable =>
      'লোকেশন বন্ধ বা অনুমতি প্রত্যাখ্যাত, তাই আপনার অবস্থানের জন্য নামাযের সময় ও কিবলা হিসাব করা যাচ্ছে না। এর জায়গায় কোনো অনুমান দেখানো হয় না।';

  @override
  String prayerLocationLine(String lat, String lng) {
    return 'আপনার অবস্থানের জন্য ($lat, $lng)';
  }

  @override
  String get salahFajr => 'ফজর';

  @override
  String get salahDhuhr => 'যোহর';

  @override
  String get salahAsr => 'আসর';

  @override
  String get salahMaghrib => 'মাগরিব';

  @override
  String get salahIsha => 'এশা';

  @override
  String get prayerNext => 'পরবর্তী';

  @override
  String get prayerMethodNote =>
      'করাচি গণনা পদ্ধতি। পদ্ধতির চূড়ান্ত অনুমোদন শরিয়াহ বোর্ডের কাছে অপেক্ষমাণ।';

  @override
  String get qiblaTitle => 'কিবলা';

  @override
  String qiblaBearingLine(String degrees) {
    return 'উত্তর থেকে $degrees°';
  }

  @override
  String get qiblaFallbackNote =>
      'এই ডিভাইসে কম্পাস রিডিং পাওয়া যাচ্ছে না, তাই ডায়ালটি ঘুরছে না। ওপরের কোণটি একটি বাস্তব কম্পাসের সাথে ব্যবহার করুন।';

  @override
  String get prayerAlarmsTitle => 'নামাযের অ্যালার্ম';

  @override
  String get prayerAlarmPermissionDenied =>
      'নোটিফিকেশনের অনুমতি প্রত্যাখ্যাত হয়েছে, তাই অ্যালার্ম বন্ধ থাকছে।';

  @override
  String salahAlarmTitle(String salah) {
    return '$salah-এর সময় হয়েছে';
  }

  @override
  String get salahAlarmBody =>
      'আপনি যে নামাযের কথা মনে করিয়ে দিতে বলেছিলেন তার সময় হয়েছে।';

  @override
  String barakahScoreTitle(int score) {
    return 'বারাকাহ স্কোর · $score';
  }

  @override
  String get barakahScoreHonesty =>
      'এটি শুধু আপনার অ্যাপ-অভ্যাস প্রতিফলিত করে: দান, আপনার নিজের চেক-ইন ও কাউন্টার ব্যবহার। এটি কখনও ইবাদত নিজে মাপে না, এবং অন্য কাউকে কখনও দেখানো হয় না।';

  @override
  String get tasbihTitle => 'আযকার ও তাসবিহ';

  @override
  String tasbihProgress(int count, int target) {
    return 'আজ $target-এর মধ্যে $count';
  }

  @override
  String get dailyItemTitle => 'দৈনিক ভাবনা';

  @override
  String get dailyItemFavourite => 'পছন্দে রাখুন';

  @override
  String get dailyItemBoardGated =>
      'শরিয়াহ বোর্ডের পর্যালোচনার পর লেখাটি এখানে আসবে। পছন্দে রাখা এখনই কাজ করে এবং পর্যালোচনার পরেও থাকবে।';

  @override
  String get dailyItemQuran2261 => 'কুরআন ২:২৬১, বহুগুণ দানের বিষয়ে';

  @override
  String get dailyItemHadithConsistency =>
      'হাদিস: সবচেয়ে প্রিয় আমল হলো নিয়মিত আমল';

  @override
  String get dailyItemQuran1328 => 'কুরআন ১৩:২৮, অন্তরের প্রশান্তির বিষয়ে';

  @override
  String get prayerCheckTitle => 'নামাযের চেক-ইন';

  @override
  String prayerCheckStreak(int days) {
    return 'চলমান ধারা: $days দিন';
  }

  @override
  String get prayerCheckHonesty =>
      'নিজের জানানো, শুধু আপনার নিজের ধারাবাহিকতার জন্য। একদিন বাদ গেলে আবার শুরু হয়; কিছুই হারায় না এবং কেউ এটি দেখে না।';

  @override
  String get prayerCheckCta => 'আজ নামায পড়েছি';

  @override
  String get prayerCheckDone => 'আজকের চেক-ইন হয়েছে।';

  @override
  String get barakahLearnNext => 'শেখা চালিয়ে যান';

  @override
  String get barakahSadaqahNudge => 'আজকের সাদাকাহ';
}
