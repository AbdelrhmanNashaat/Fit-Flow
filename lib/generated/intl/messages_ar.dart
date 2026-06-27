// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ar';

  static String m0(v) => "الإصدار ${v}";

  static String m1(n) => "{n, select, 5{5+ أيام} other{${n} أيام}}";

  static String m2(n) => "${n} أيام/أسبوع";

  static String m3(n) =>
      "${Intl.plural(n, one: 'تمرين واحد', other: '${n} تمرين')}";

  static String m4(monthYear) => "عضو متميز منذ ${monthYear}";

  static String m5(n) =>
      "${Intl.plural(n, one: 'مجموعة واحدة', other: '${n} مجموعة')}";

  static String m6(n) => "الأسبوع ${n}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "activeGoal": MessageLookupByLibrary.simpleMessage("الهدف النشط"),
    "activePlan": MessageLookupByLibrary.simpleMessage("الخطة النشطة"),
    "activity": MessageLookupByLibrary.simpleMessage("النشاط"),
    "addSet": MessageLookupByLibrary.simpleMessage("+ أضف مجموعة"),
    "alreadyHaveAccount": MessageLookupByLibrary.simpleMessage(
      "لديك حساب بالفعل؟",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("فيت فلو"),
    "appVersion": m0,
    "apple": MessageLookupByLibrary.simpleMessage("أبل"),
    "arabic": MessageLookupByLibrary.simpleMessage("العربية"),
    "authBrandName": MessageLookupByLibrary.simpleMessage("فيت فلو بيور"),
    "availabilityDaysOption": m1,
    "backToSignIn": MessageLookupByLibrary.simpleMessage(
      "العودة إلى تسجيل الدخول",
    ),
    "buildMuscle": MessageLookupByLibrary.simpleMessage("بناء العضلات"),
    "buildMuscleSubtitle": MessageLookupByLibrary.simpleMessage(
      "ركز على التضخيم وبناء القوة.",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("إلغاء"),
    "checkYourInbox": MessageLookupByLibrary.simpleMessage("تحقق من بريدك"),
    "confirm": MessageLookupByLibrary.simpleMessage("تأكيد"),
    "confirmPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "تأكيد كلمة المرور",
    ),
    "confirmPasswordRequiredError": MessageLookupByLibrary.simpleMessage(
      "يرجى تأكيد كلمة المرور",
    ),
    "createAccount": MessageLookupByLibrary.simpleMessage("إنشاء حساب"),
    "createAccountNav": MessageLookupByLibrary.simpleMessage("إنشاء حساب"),
    "createAccountSubtitle": MessageLookupByLibrary.simpleMessage(
      "أنشئ حسابك للبدء.",
    ),
    "daysPerWeek": m2,
    "delete": MessageLookupByLibrary.simpleMessage("حذف"),
    "deleteAccount": MessageLookupByLibrary.simpleMessage("حذف الحساب"),
    "deleteAccountMessage": MessageLookupByLibrary.simpleMessage(
      "هذا الإجراء دائم ولا يمكن التراجع عنه. سيتم حذف جميع بياناتك.",
    ),
    "deleteAccountTitle": MessageLookupByLibrary.simpleMessage("حذف الحساب"),
    "done": MessageLookupByLibrary.simpleMessage("تم"),
    "doneHeader": MessageLookupByLibrary.simpleMessage("تم"),
    "elapsedTime": MessageLookupByLibrary.simpleMessage("الوقت المنقضي"),
    "emailAddressLabel": MessageLookupByLibrary.simpleMessage(
      "البريد الإلكتروني",
    ),
    "emailInvalidError": MessageLookupByLibrary.simpleMessage(
      "أدخل بريداً إلكترونياً صالحاً",
    ),
    "emailRequiredError": MessageLookupByLibrary.simpleMessage(
      "البريد الإلكتروني مطلوب",
    ),
    "english": MessageLookupByLibrary.simpleMessage("الإنجليزية"),
    "errorLabel": MessageLookupByLibrary.simpleMessage("خطأ"),
    "exerciseCount": m3,
    "exercises": MessageLookupByLibrary.simpleMessage("تمارين"),
    "finishExercise": MessageLookupByLibrary.simpleMessage("إنهاء"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "هل نسيت كلمة المرور؟",
    ),
    "forgotPasswordDescription": MessageLookupByLibrary.simpleMessage(
      "أدخل البريد الإلكتروني المرتبط بحسابك وسنرسل لك رابط إعادة التعيين.",
    ),
    "formCues": MessageLookupByLibrary.simpleMessage("نصائح الأداء"),
    "frequency": MessageLookupByLibrary.simpleMessage("التكرار"),
    "fullNameLabel": MessageLookupByLibrary.simpleMessage("الاسم الكامل"),
    "fullNameRequiredError": MessageLookupByLibrary.simpleMessage(
      "الاسم الكامل مطلوب",
    ),
    "fullNameTooShortError": MessageLookupByLibrary.simpleMessage(
      "يجب أن يتكون الاسم من حرفين على الأقل",
    ),
    "generalFitness": MessageLookupByLibrary.simpleMessage("اللياقة العامة"),
    "generalFitnessSubtitle": MessageLookupByLibrary.simpleMessage(
      "توازن بين الصحة والحركة.",
    ),
    "getStrong": MessageLookupByLibrary.simpleMessage("زيادة القوة"),
    "getStrongSubtitle": MessageLookupByLibrary.simpleMessage(
      "اجعل الأولوية للقوة والأوزان الثقيلة.",
    ),
    "goodAfternoon": MessageLookupByLibrary.simpleMessage("مساء الخير"),
    "goodEvening": MessageLookupByLibrary.simpleMessage("مساء النور"),
    "goodMorning": MessageLookupByLibrary.simpleMessage("صباح الخير"),
    "google": MessageLookupByLibrary.simpleMessage("جوجل"),
    "healthProfile": MessageLookupByLibrary.simpleMessage("الملف الصحي"),
    "home": MessageLookupByLibrary.simpleMessage("الرئيسية"),
    "kcal": MessageLookupByLibrary.simpleMessage("سعرة"),
    "kg": MessageLookupByLibrary.simpleMessage("كغ"),
    "language": MessageLookupByLibrary.simpleMessage("اللغة"),
    "learn": MessageLookupByLibrary.simpleMessage("تعلّم"),
    "legalLabel": MessageLookupByLibrary.simpleMessage("قانوني"),
    "letsGetMoving": MessageLookupByLibrary.simpleMessage("هيا نتحرك!"),
    "letsGetToWork": MessageLookupByLibrary.simpleMessage("هيا نعمل!"),
    "letsRestToday": MessageLookupByLibrary.simpleMessage("استرح اليوم"),
    "logOut": MessageLookupByLibrary.simpleMessage("تسجيل الخروج"),
    "logOutConfirmMessage": MessageLookupByLibrary.simpleMessage(
      "هل تريد تسجيل الخروج؟",
    ),
    "logOutConfirmTitle": MessageLookupByLibrary.simpleMessage("تسجيل الخروج"),
    "memberSince": m4,
    "minutes": MessageLookupByLibrary.simpleMessage("دقيقة"),
    "newToFitFlow": MessageLookupByLibrary.simpleMessage("جديد على FitFlow؟"),
    "next": MessageLookupByLibrary.simpleMessage("التالي"),
    "noWorkoutPlan": MessageLookupByLibrary.simpleMessage(
      "لم يتم العثور على خطة تمرين.",
    ),
    "notSet": MessageLookupByLibrary.simpleMessage("غير محدد"),
    "onboardingAvailabilityTitle": MessageLookupByLibrary.simpleMessage(
      "التوفر الأسبوعي",
    ),
    "onboardingChangeLater": MessageLookupByLibrary.simpleMessage(
      "يمكنك تغيير هذا لاحقاً من الملف الشخصي",
    ),
    "onboardingContinue": MessageLookupByLibrary.simpleMessage("متابعة"),
    "onboardingSubtitle": MessageLookupByLibrary.simpleMessage(
      "خصص رحلتك لتناسب أداءك بدقة.",
    ),
    "onboardingTitle": MessageLookupByLibrary.simpleMessage("اختر هدفك"),
    "orContinueWith": MessageLookupByLibrary.simpleMessage("أو تابع باستخدام"),
    "passwordLabel": MessageLookupByLibrary.simpleMessage("كلمة المرور"),
    "passwordRequiredError": MessageLookupByLibrary.simpleMessage(
      "كلمة المرور مطلوبة",
    ),
    "passwordTooShortError": MessageLookupByLibrary.simpleMessage(
      "يجب أن تكون كلمة المرور 8 أحرف على الأقل",
    ),
    "passwordsDoNotMatchError": MessageLookupByLibrary.simpleMessage(
      "كلمتا المرور غير متطابقتين",
    ),
    "preferencesAccount": MessageLookupByLibrary.simpleMessage(
      "التفضيلات والحساب",
    ),
    "previous": MessageLookupByLibrary.simpleMessage("السابق"),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("سياسة الخصوصية"),
    "proMemberSince": MessageLookupByLibrary.simpleMessage("عضو متميز منذ"),
    "profile": MessageLookupByLibrary.simpleMessage("الملف"),
    "profileUnavailable": MessageLookupByLibrary.simpleMessage(
      "الملف غير متوفر. الرجاء تسجيل الدخول مجدداً.",
    ),
    "reauthMessage": MessageLookupByLibrary.simpleMessage(
      "أدخل كلمة المرور لتأكيد حذف الحساب.",
    ),
    "reauthTitle": MessageLookupByLibrary.simpleMessage("تأكيد هويتك"),
    "recommendationRecoveryCycle": MessageLookupByLibrary.simpleMessage(
      "دورة تعافٍ مثالية",
    ),
    "recommendedLabel": MessageLookupByLibrary.simpleMessage("موصى به"),
    "recovery": MessageLookupByLibrary.simpleMessage("التعافي"),
    "reps": MessageLookupByLibrary.simpleMessage("تكرار"),
    "repsHeader": MessageLookupByLibrary.simpleMessage("تكرار"),
    "reset": MessageLookupByLibrary.simpleMessage("إعادة ضبط"),
    "resetLinkSentBody": MessageLookupByLibrary.simpleMessage(
      "إذا وُجد حساب لهذا البريد، فستتلقى قريباً رابطاً لإعادة تعيين كلمة المرور.",
    ),
    "resetPlanMessage": MessageLookupByLibrary.simpleMessage(
      "سيتم إعادة ضبط أهدافك وإعادة تشغيل الإعداد.",
    ),
    "resetPlanTitle": MessageLookupByLibrary.simpleMessage("إعادة ضبط الخطة"),
    "resetWorkoutPlan": MessageLookupByLibrary.simpleMessage(
      "إعادة ضبط خطة التمرين",
    ),
    "restDay": MessageLookupByLibrary.simpleMessage("يوم راحة"),
    "restDayMessage": MessageLookupByLibrary.simpleMessage(
      "خذ قسطاً من الراحة اليوم.",
    ),
    "saveAndStart": MessageLookupByLibrary.simpleMessage("حفظ والبدء"),
    "saveWeight": MessageLookupByLibrary.simpleMessage("حفظ"),
    "selectLanguage": MessageLookupByLibrary.simpleMessage("اختر اللغة"),
    "sendResetLink": MessageLookupByLibrary.simpleMessage(
      "إرسال رابط إعادة التعيين",
    ),
    "setCount": m5,
    "setNumber": MessageLookupByLibrary.simpleMessage("مج"),
    "sets": MessageLookupByLibrary.simpleMessage("مجموعات"),
    "signIn": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
    "signInNav": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
    "skipWeight": MessageLookupByLibrary.simpleMessage("تخطى"),
    "splashTagline": MessageLookupByLibrary.simpleMessage("ارتق بحركتك"),
    "startRestTimer": MessageLookupByLibrary.simpleMessage("ابدأ مؤقت الراحة"),
    "startWorkout": MessageLookupByLibrary.simpleMessage("ابدأ التمرين  ▶"),
    "startingWeight": MessageLookupByLibrary.simpleMessage("أدخل وزن البداية"),
    "startingWeightSubtitle": MessageLookupByLibrary.simpleMessage(
      "لا تقلق، يمكنك تحديثه لاحقاً في أي وقت.",
    ),
    "summary": MessageLookupByLibrary.simpleMessage("ملخص"),
    "termsAndPrivacyLabel": MessageLookupByLibrary.simpleMessage(
      "شروط الاستخدام  ·  سياسة الخصوصية",
    ),
    "termsOfService": MessageLookupByLibrary.simpleMessage("شروط الخدمة"),
    "todayExercises": MessageLookupByLibrary.simpleMessage("تمارين اليوم"),
    "todayWorkout": MessageLookupByLibrary.simpleMessage("تمرين اليوم"),
    "tryAgain": MessageLookupByLibrary.simpleMessage("حاول مرة أخرى"),
    "useDefault": MessageLookupByLibrary.simpleMessage("استخدم الافتراضي"),
    "validationAddWeight": MessageLookupByLibrary.simpleMessage(
      "كل مجموعة تحتاج وزناً لا يقل عن 1 كغ.",
    ),
    "validationCompleteAllSets": MessageLookupByLibrary.simpleMessage(
      "أكمل جميع المجموعات قبل المتابعة.",
    ),
    "vitals": MessageLookupByLibrary.simpleMessage("القياسات"),
    "weekLabel": m6,
    "weeklyBlueprint": MessageLookupByLibrary.simpleMessage("الخطة الأسبوعية"),
    "weeklyBurn": MessageLookupByLibrary.simpleMessage("الحرق الأسبوعي"),
    "weight": MessageLookupByLibrary.simpleMessage("الوزن"),
    "weightHeader": MessageLookupByLibrary.simpleMessage("الوزن"),
    "welcomeBackSubtitle": MessageLookupByLibrary.simpleMessage(
      "مرحباً بعودتك. لنواصل التقدم.",
    ),
    "workoutSession": MessageLookupByLibrary.simpleMessage("جلسة التمرين"),
  };
}
