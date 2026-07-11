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
}
