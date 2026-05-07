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
  String get proMemberSince =>
      _t(en: 'Pro Member Since', ar: 'عضو متميز منذ');
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
  String get privacyPolicy =>
      _t(en: 'Privacy Policy', ar: 'سياسة الخصوصية');
  String get termsOfService =>
      _t(en: 'Terms of Service', ar: 'شروط الخدمة');

  // ─── Language names ────────────────────────────────────────────────────────
  String get english => _t(en: 'English', ar: 'الإنجليزية');
  String get arabic => _t(en: 'Arabic', ar: 'العربية');
  String get selectLanguage =>
      _t(en: 'Select Language', ar: 'اختر اللغة');

  // ─── Common actions ────────────────────────────────────────────────────────
  String get cancel => _t(en: 'Cancel', ar: 'إلغاء');
  String get confirm => _t(en: 'Confirm', ar: 'تأكيد');
  String get delete => _t(en: 'Delete', ar: 'حذف');
  String get reset => _t(en: 'Reset', ar: 'إعادة ضبط');
  String get tryAgain => _t(en: 'Try Again', ar: 'حاول مرة أخرى');

  // ─── Dialogs ───────────────────────────────────────────────────────────────
  String get logOutConfirmTitle => _t(en: 'Log Out', ar: 'تسجيل الخروج');
  String get logOutConfirmMessage => _t(
    en: 'Are you sure you want to log out?',
    ar: 'هل تريد تسجيل الخروج؟',
  );
  String get deleteAccountTitle =>
      _t(en: 'Delete Account', ar: 'حذف الحساب');
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
  String get reauthTitle =>
      _t(en: 'Confirm Your Identity', ar: 'تأكيد هويتك');
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
  String get startWorkout =>
      _t(en: 'Start Workout  ▶', ar: 'ابدأ التمرين  ▶');
  String get exercises => _t(en: 'Exercises', ar: 'تمارين');
  String get sets => _t(en: 'Sets', ar: 'مجموعات');
  String get reps => _t(en: 'Reps', ar: 'تكرار');
  String get activePlan => _t(en: 'ACTIVE PLAN', ar: 'الخطة النشطة');
  String get todayExercises =>
      _t(en: "Today's Exercises", ar: 'تمارين اليوم');
  String get minutes => _t(en: 'Minutes', ar: 'دقيقة');
  String get recovery => _t(en: 'Recovery', ar: 'التعافي');
  String get weeklyBurn => _t(en: 'Weekly Burn', ar: 'الحرق الأسبوعي');
  String get kcal => _t(en: 'kcal', ar: 'سعرة');
  String get letsGetToWork => _t(en: "Let's get to work.", ar: 'هيا نعمل!');
  String get letsRestToday => _t(en: 'Rest & recover today.', ar: 'استرح اليوم');
  String get weight => _t(en: 'Weight', ar: 'الوزن');
  String get kg => _t(en: 'kg', ar: 'كغ');
  String get noWorkoutPlan =>
      _t(en: 'No workout plan found.', ar: 'لم يتم العثور على خطة تمرين.');
  String get goodMorning => _t(en: 'Good morning', ar: 'صباح الخير');
  String get goodAfternoon => _t(en: 'Good afternoon', ar: 'مساء الخير');
  String get goodEvening => _t(en: 'Good evening', ar: 'مساء النور');
  String get letsGetMoving =>
      _t(en: "Let's get moving!", ar: 'هيا نتحرك!');
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
  String get useDefault => _t(en: 'Not sure? Use default', ar: 'استخدم الافتراضي');
  String get saveWeight => _t(en: 'Save', ar: 'حفظ');
  String get skipWeight => _t(en: 'Skip', ar: 'تخطى');

  // ─── Parameterized strings ─────────────────────────────────────────────────
  String daysPerWeek(int n) =>
      _t(en: '$n Days/Week', ar: '$n أيام/أسبوع');

  String appVersion(String v) =>
      _t(en: 'Version $v', ar: 'الإصدار $v');

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
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ];
    const ar = [
      'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
      'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر',
    ];
    final months = _locale.languageCode == 'ar' ? ar : en;
    return months[month - 1];
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async =>
      AppLocalizations(locale);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
