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
  String get summary => _t(en: 'Summary', ar: 'ملخص');
  String get activity => _t(en: 'Activity', ar: 'النشاط');
  String get vitals => _t(en: 'Vitals', ar: 'القياسات');
  String get profile => _t(en: 'Profile', ar: 'الملف');

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

  // ─── Parameterized strings ─────────────────────────────────────────────────
  String daysPerWeek(int n) =>
      _t(en: '$n Days/Week', ar: '$n أيام/أسبوع');

  String appVersion(String v) =>
      _t(en: 'Version $v', ar: 'الإصدار $v');

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
