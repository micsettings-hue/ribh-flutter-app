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
}
