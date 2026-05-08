import 'package:flutter/material.dart';

class AppLocalizations {
  const AppLocalizations(this._locale);

  final Locale _locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [Locale('en'), Locale('ar')];

  // ─── App ───────────────────────────────────────────────────────────────────
  String get appName => _t(en: 'FitFlow', ar: 'فيت فلو');
  String get authBrandName => _t(en: 'FitFlow Pure', ar: 'فيت فلو بيور');
  String get splashTagline =>
      _t(en: 'Elevate Your Movement', ar: 'ارتق بحركتك');

  // ─── Auth ──────────────────────────────────────────────────────────────────
  String get signIn => _t(en: 'Sign In', ar: 'تسجيل الدخول');
  String get createAccount => _t(en: 'Create Account', ar: 'إنشاء حساب');
  String get forgotPassword =>
      _t(en: 'Forgot Password?', ar: 'هل نسيت كلمة المرور؟');
  String get welcomeBackSubtitle => _t(
    en: 'Welcome back. Let\'s keep moving.',
    ar: 'مرحباً بعودتك. لنواصل التقدم.',
  );
  String get createAccountSubtitle =>
      _t(en: 'Create your account to get started.', ar: 'أنشئ حسابك للبدء.');
  String get emailAddressLabel =>
      _t(en: 'Email Address', ar: 'البريد الإلكتروني');
  String get fullNameLabel => _t(en: 'Full Name', ar: 'الاسم الكامل');
  String get confirmPasswordLabel =>
      _t(en: 'Confirm Password', ar: 'تأكيد كلمة المرور');
  String get forgotPasswordDescription => _t(
    en: 'Enter the email linked to your account and we\'ll send you a reset link.',
    ar: 'أدخل البريد الإلكتروني المرتبط بحسابك وسنرسل لك رابط إعادة التعيين.',
  );
  String get sendResetLink =>
      _t(en: 'Send Reset Link', ar: 'إرسال رابط إعادة التعيين');
  String get checkYourInbox => _t(en: 'Check Your Inbox', ar: 'تحقق من بريدك');
  String get resetLinkSentBody => _t(
    en: 'If an account exists for this email, you\'ll receive a password reset link shortly.',
    ar: 'إذا وُجد حساب لهذا البريد، فستتلقى قريباً رابطاً لإعادة تعيين كلمة المرور.',
  );
  String get backToSignIn =>
      _t(en: 'Back to Sign In', ar: 'العودة إلى تسجيل الدخول');
  String get newToFitFlow => _t(en: 'New to FitFlow?', ar: 'جديد على FitFlow؟');
  String get createAccountNav => _t(en: 'Create an account', ar: 'إنشاء حساب');
  String get alreadyHaveAccount =>
      _t(en: 'Already have an account?', ar: 'لديك حساب بالفعل؟');
  String get signInNav => _t(en: 'Sign in', ar: 'تسجيل الدخول');
  String get termsAndPrivacyLabel => _t(
    en: 'Terms of Use  ·  Privacy Policy',
    ar: 'شروط الاستخدام  ·  سياسة الخصوصية',
  );
  String get orContinueWith =>
      _t(en: 'or continue with', ar: 'أو تابع باستخدام');
  String get google => _t(en: 'Google', ar: 'جوجل');
  String get apple => _t(en: 'Apple', ar: 'أبل');

  // ─── Onboarding ───────────────────────────────────────────────────────────
  String get onboardingTitle => _t(en: 'Select Your Goal', ar: 'اختر هدفك');
  String get onboardingSubtitle => _t(
    en: 'Customize your journey for precision performance.',
    ar: 'خصص رحلتك لتناسب أداءك بدقة.',
  );
  String get onboardingAvailabilityTitle =>
      _t(en: 'Weekly Availability', ar: 'التوفر الأسبوعي');
  String get onboardingContinue => _t(en: 'Continue', ar: 'متابعة');
  String get onboardingChangeLater => _t(
    en: 'YOU CAN CHANGE THIS LATER IN PROFILE',
    ar: 'يمكنك تغيير هذا لاحقاً من الملف الشخصي',
  );
  String get buildMuscleSubtitle => _t(
    en: 'Focus on hypertrophy and strength.',
    ar: 'ركز على التضخيم وبناء القوة.',
  );
  String get getStrongSubtitle => _t(
    en: 'Prioritize heavy lifting and power.',
    ar: 'اجعل الأولوية للقوة والأوزان الثقيلة.',
  );
  String get generalFitnessSubtitle =>
      _t(en: 'Balanced health and mobility.', ar: 'توازن بين الصحة والحركة.');
  String get recommendedLabel => _t(en: 'RECOMMENDED', ar: 'موصى به');
  String get recommendationRecoveryCycle =>
      _t(en: 'Optimal recovery cycle', ar: 'دورة تعافٍ مثالية');

  // ─── Validation ────────────────────────────────────────────────────────────
  String get emailRequiredError =>
      _t(en: 'Email is required', ar: 'البريد الإلكتروني مطلوب');
  String get emailInvalidError => _t(
    en: 'Enter a valid email address',
    ar: 'أدخل بريداً إلكترونياً صالحاً',
  );
  String get passwordRequiredError =>
      _t(en: 'Password is required', ar: 'كلمة المرور مطلوبة');
  String get passwordTooShortError => _t(
    en: 'Password must be at least 8 characters',
    ar: 'يجب أن تكون كلمة المرور 8 أحرف على الأقل',
  );
  String get fullNameRequiredError =>
      _t(en: 'Full name is required', ar: 'الاسم الكامل مطلوب');
  String get fullNameTooShortError => _t(
    en: 'Name must be at least 2 characters',
    ar: 'يجب أن يتكون الاسم من حرفين على الأقل',
  );
  String get confirmPasswordRequiredError =>
      _t(en: 'Please confirm your password', ar: 'يرجى تأكيد كلمة المرور');
  String get passwordsDoNotMatchError =>
      _t(en: 'Passwords do not match', ar: 'كلمتا المرور غير متطابقتين');

  // ─── Navigation tabs ───────────────────────────────────────────────────────
  String get home => _t(en: 'Home', ar: 'الرئيسية');
  String get learn => _t(en: 'Learn', ar: 'تعلّم');
  String get profile => _t(en: 'Profile', ar: 'الملف');

  // ─── Legacy tabs (kept for any remaining references) ──────────────────────
  String get summary => _t(en: 'Summary', ar: 'ملخص');
  String get activity => _t(en: 'Activity', ar: 'النشاط');
  String get vitals => _t(en: 'Vitals', ar: 'القياسات');

  // ─── Profile screen ────────────────────────────────────────────────────────
  String get healthProfile => _t(en: 'Health Profile', ar: 'الملف الصحي');
  String get preferencesAccount =>
      _t(en: 'Preferences & Account', ar: 'التفضيلات والحساب');
  String get proMemberSince => _t(en: 'Pro Member Since', ar: 'عضو متميز منذ');
  String get activeGoal => _t(en: 'ACTIVE GOAL', ar: 'الهدف النشط');
  String get frequency => _t(en: 'FREQUENCY', ar: 'التكرار');
  String get legalLabel => _t(en: 'Legal', ar: 'قانوني');
  String get profileUnavailable => _t(
    en: 'Profile unavailable. Please sign in again.',
    ar: 'الملف غير متوفر. الرجاء تسجيل الدخول مجدداً.',
  );

  // ─── Goal values ───────────────────────────────────────────────────────────
  String get buildMuscle => _t(en: 'Build Muscle', ar: 'بناء العضلات');
  String get getStrong => _t(en: 'Get Strong', ar: 'زيادة القوة');
  String get generalFitness => _t(en: 'General Fitness', ar: 'اللياقة العامة');
  String get notSet => _t(en: 'Not Set', ar: 'غير محدد');

  // ─── Menu tile labels ──────────────────────────────────────────────────────
  String get language => _t(en: 'Language', ar: 'اللغة');
  String get resetWorkoutPlan =>
      _t(en: 'Reset Workout Plan', ar: 'إعادة ضبط خطة التمرين');
  String get logOut => _t(en: 'Log Out', ar: 'تسجيل الخروج');
  String get deleteAccount => _t(en: 'Delete Account', ar: 'حذف الحساب');
  String get privacyPolicy => _t(en: 'Privacy Policy', ar: 'سياسة الخصوصية');
  String get termsOfService => _t(en: 'Terms of Service', ar: 'شروط الخدمة');

  // ─── Language names ────────────────────────────────────────────────────────
  String get english => _t(en: 'English', ar: 'الإنجليزية');
  String get arabic => _t(en: 'Arabic', ar: 'العربية');
  String get selectLanguage => _t(en: 'Select Language', ar: 'اختر اللغة');

  // ─── Common actions ────────────────────────────────────────────────────────
  String get cancel => _t(en: 'Cancel', ar: 'إلغاء');
  String get confirm => _t(en: 'Confirm', ar: 'تأكيد');
  String get delete => _t(en: 'Delete', ar: 'حذف');
  String get reset => _t(en: 'Reset', ar: 'إعادة ضبط');
  String get tryAgain => _t(en: 'Try Again', ar: 'حاول مرة أخرى');

  // ─── Dialogs ───────────────────────────────────────────────────────────────
  String get logOutConfirmTitle => _t(en: 'Log Out', ar: 'تسجيل الخروج');
  String get logOutConfirmMessage =>
      _t(en: 'Are you sure you want to log out?', ar: 'هل تريد تسجيل الخروج؟');
  String get deleteAccountTitle => _t(en: 'Delete Account', ar: 'حذف الحساب');
  String get deleteAccountMessage => _t(
    en: 'This action is permanent and cannot be undone. All your data will be deleted.',
    ar: 'هذا الإجراء دائم ولا يمكن التراجع عنه. سيتم حذف جميع بياناتك.',
  );
  String get resetPlanTitle =>
      _t(en: 'Reset Workout Plan', ar: 'إعادة ضبط الخطة');
  String get resetPlanMessage => _t(
    en: 'This will reset your goals and restart the onboarding flow.',
    ar: 'سيتم إعادة ضبط أهدافك وإعادة تشغيل الإعداد.',
  );
  String get reauthTitle => _t(en: 'Confirm Your Identity', ar: 'تأكيد هويتك');
  String get reauthMessage => _t(
    en: 'Please enter your password to confirm account deletion.',
    ar: 'أدخل كلمة المرور لتأكيد حذف الحساب.',
  );
  String get passwordLabel => _t(en: 'Password', ar: 'كلمة المرور');
  String get errorLabel => _t(en: 'Error', ar: 'خطأ');

  // ─── Home dashboard ────────────────────────────────────────────────────────
  String get todayWorkout => _t(en: "Today's Workout", ar: 'تمرين اليوم');
  String get restDay => _t(en: 'Rest Day', ar: 'يوم راحة');
  String get weeklyBlueprint =>
      _t(en: 'Weekly Blueprint', ar: 'الخطة الأسبوعية');
  String get startWorkout => _t(en: 'Start Workout  ▶', ar: 'ابدأ التمرين  ▶');
  String get exercises => _t(en: 'Exercises', ar: 'تمارين');
  String get sets => _t(en: 'Sets', ar: 'مجموعات');
  String get reps => _t(en: 'Reps', ar: 'تكرار');
  String get activePlan => _t(en: 'ACTIVE PLAN', ar: 'الخطة النشطة');
  String get todayExercises => _t(en: "Today's Exercises", ar: 'تمارين اليوم');
  String get minutes => _t(en: 'Minutes', ar: 'دقيقة');
  String get recovery => _t(en: 'Recovery', ar: 'التعافي');
  String get weeklyBurn => _t(en: 'Weekly Burn', ar: 'الحرق الأسبوعي');
  String get kcal => _t(en: 'kcal', ar: 'سعرة');
  String get letsGetToWork => _t(en: "Let's get to work.", ar: 'هيا نعمل!');
  String get letsRestToday =>
      _t(en: 'Rest & recover today.', ar: 'استرح اليوم');
  String get weight => _t(en: 'Weight', ar: 'الوزن');
  String get kg => _t(en: 'kg', ar: 'كغ');
  String get noWorkoutPlan =>
      _t(en: 'No workout plan found.', ar: 'لم يتم العثور على خطة تمرين.');
  String get goodMorning => _t(en: 'Good morning', ar: 'صباح الخير');
  String get goodAfternoon => _t(en: 'Good afternoon', ar: 'مساء الخير');
  String get goodEvening => _t(en: 'Good evening', ar: 'مساء النور');
  String get letsGetMoving => _t(en: "Let's get moving!", ar: 'هيا نتحرك!');
  String get restDayMessage =>
      _t(en: 'Take it easy today.', ar: 'خذ قسطاً من الراحة اليوم.');

  // ─── Active exercise screen ─────────────────────────────────────────────────
  String get finishExercise => _t(en: 'Finish', ar: 'إنهاء');
  String get addSet => _t(en: '+ ADD SET', ar: '+ أضف مجموعة');
  String get formCues => _t(en: 'FORM CUES', ar: 'نصائح الأداء');
  String get elapsedTime => _t(en: 'Elapsed', ar: 'الوقت المنقضي');
  String get setNumber => _t(en: 'SET', ar: 'مج');
  String get weightHeader => _t(en: 'WEIGHT', ar: 'الوزن');
  String get repsHeader => _t(en: 'REPS', ar: 'تكرار');
  String get doneHeader => _t(en: 'DONE', ar: 'تم');
  String get done => _t(en: 'Done', ar: 'تم');
  String get previous => _t(en: 'Previous', ar: 'السابق');
  String get next => _t(en: 'Next', ar: 'التالي');
  String get workoutSession => _t(en: 'Workout Session', ar: 'جلسة التمرين');
  String get startRestTimer =>
      _t(en: 'Start Rest Timer', ar: 'ابدأ مؤقت الراحة');
  String get validationCompleteAllSets => _t(
    en: 'Complete all sets before continuing.',
    ar: 'أكمل جميع المجموعات قبل المتابعة.',
  );
  String get validationAddWeight => _t(
    en: 'Each set needs at least 1 kg.',
    ar: 'كل مجموعة تحتاج وزناً لا يقل عن 1 كغ.',
  );

  // ─── Starting weight dialog ────────────────────────────────────────────────
  String get startingWeight =>
      _t(en: 'Enter Starting Weight', ar: 'أدخل وزن البداية');
  String get startingWeightSubtitle => _t(
    en: "Don't worry, you can update this later whenever you want.",
    ar: 'لا تقلق، يمكنك تحديثه لاحقاً في أي وقت.',
  );
  String get saveAndStart => _t(en: 'Save & Start', ar: 'حفظ والبدء');
  String get useDefault =>
      _t(en: 'Not sure? Use default', ar: 'استخدم الافتراضي');
  String get saveWeight => _t(en: 'Save', ar: 'حفظ');
  String get skipWeight => _t(en: 'Skip', ar: 'تخطى');

  // ─── Parameterized strings ─────────────────────────────────────────────────
  String daysPerWeek(int n) => _t(en: '$n Days/Week', ar: '$n أيام/أسبوع');

  String availabilityDaysOption(int n) => _t(
    en: n == 5 ? '5+ Days' : '$n Days',
    ar: n == 5 ? '5+ أيام' : '$n أيام',
  );

  String appVersion(String v) => _t(en: 'Version $v', ar: 'الإصدار $v');

  String weekLabel(int n) => _t(en: 'Week $n', ar: 'الأسبوع $n');

  String exerciseCount(int n) =>
      _t(en: '$n exercise${n == 1 ? '' : 's'}', ar: '$n تمرين');

  String setCount(int n) =>
      _t(en: '$n set${n == 1 ? '' : 's'}', ar: '$n مجموعة');

  String memberSince(DateTime date) {
    final month = _monthName(date.month);
    return _t(
      en: 'Pro Member Since $month ${date.year}',
      ar: 'عضو متميز منذ $month ${date.year}',
    );
  }

  // ─── Private helpers ───────────────────────────────────────────────────────
  String _t({required String en, required String ar}) =>
      _locale.languageCode == 'ar' ? ar : en;

  String _monthName(int month) {
    const en = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    const ar = [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];
    final months = _locale.languageCode == 'ar' ? ar : en;
    return months[month - 1];
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async =>
      AppLocalizations(locale);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
