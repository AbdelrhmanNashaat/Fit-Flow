// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `FitFlow`
  String get appName {
    return Intl.message('FitFlow', name: 'appName', desc: '', args: []);
  }

  /// `FitFlow Pure`
  String get authBrandName {
    return Intl.message(
      'FitFlow Pure',
      name: 'authBrandName',
      desc: '',
      args: [],
    );
  }

  /// `Elevate Your Movement`
  String get splashTagline {
    return Intl.message(
      'Elevate Your Movement',
      name: 'splashTagline',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message('Sign In', name: 'signIn', desc: '', args: []);
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back. Let's keep moving.`
  String get welcomeBackSubtitle {
    return Intl.message(
      'Welcome back. Let\'s keep moving.',
      name: 'welcomeBackSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Create your account to get started.`
  String get createAccountSubtitle {
    return Intl.message(
      'Create your account to get started.',
      name: 'createAccountSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get emailAddressLabel {
    return Intl.message(
      'Email Address',
      name: 'emailAddressLabel',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullNameLabel {
    return Intl.message('Full Name', name: 'fullNameLabel', desc: '', args: []);
  }

  /// `Confirm Password`
  String get confirmPasswordLabel {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter the email linked to your account and we'll send you a reset link.`
  String get forgotPasswordDescription {
    return Intl.message(
      'Enter the email linked to your account and we\'ll send you a reset link.',
      name: 'forgotPasswordDescription',
      desc: '',
      args: [],
    );
  }

  /// `Send Reset Link`
  String get sendResetLink {
    return Intl.message(
      'Send Reset Link',
      name: 'sendResetLink',
      desc: '',
      args: [],
    );
  }

  /// `Check Your Inbox`
  String get checkYourInbox {
    return Intl.message(
      'Check Your Inbox',
      name: 'checkYourInbox',
      desc: '',
      args: [],
    );
  }

  /// `If an account exists for this email, you'll receive a password reset link shortly.`
  String get resetLinkSentBody {
    return Intl.message(
      'If an account exists for this email, you\'ll receive a password reset link shortly.',
      name: 'resetLinkSentBody',
      desc: '',
      args: [],
    );
  }

  /// `Back to Sign In`
  String get backToSignIn {
    return Intl.message(
      'Back to Sign In',
      name: 'backToSignIn',
      desc: '',
      args: [],
    );
  }

  /// `New to FitFlow?`
  String get newToFitFlow {
    return Intl.message(
      'New to FitFlow?',
      name: 'newToFitFlow',
      desc: '',
      args: [],
    );
  }

  /// `Create an account`
  String get createAccountNav {
    return Intl.message(
      'Create an account',
      name: 'createAccountNav',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get signInNav {
    return Intl.message('Sign in', name: 'signInNav', desc: '', args: []);
  }

  /// `Terms of Use  ·  Privacy Policy`
  String get termsAndPrivacyLabel {
    return Intl.message(
      'Terms of Use  ·  Privacy Policy',
      name: 'termsAndPrivacyLabel',
      desc: '',
      args: [],
    );
  }

  /// `or continue with`
  String get orContinueWith {
    return Intl.message(
      'or continue with',
      name: 'orContinueWith',
      desc: '',
      args: [],
    );
  }

  /// `Google`
  String get google {
    return Intl.message('Google', name: 'google', desc: '', args: []);
  }

  /// `Apple`
  String get apple {
    return Intl.message('Apple', name: 'apple', desc: '', args: []);
  }

  /// `Select Your Goal`
  String get onboardingTitle {
    return Intl.message(
      'Select Your Goal',
      name: 'onboardingTitle',
      desc: '',
      args: [],
    );
  }

  /// `Customize your journey for precision performance.`
  String get onboardingSubtitle {
    return Intl.message(
      'Customize your journey for precision performance.',
      name: 'onboardingSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Weekly Availability`
  String get onboardingAvailabilityTitle {
    return Intl.message(
      'Weekly Availability',
      name: 'onboardingAvailabilityTitle',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get onboardingContinue {
    return Intl.message(
      'Continue',
      name: 'onboardingContinue',
      desc: '',
      args: [],
    );
  }

  /// `YOU CAN CHANGE THIS LATER IN PROFILE`
  String get onboardingChangeLater {
    return Intl.message(
      'YOU CAN CHANGE THIS LATER IN PROFILE',
      name: 'onboardingChangeLater',
      desc: '',
      args: [],
    );
  }

  /// `Focus on hypertrophy and strength.`
  String get buildMuscleSubtitle {
    return Intl.message(
      'Focus on hypertrophy and strength.',
      name: 'buildMuscleSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Prioritize heavy lifting and power.`
  String get getStrongSubtitle {
    return Intl.message(
      'Prioritize heavy lifting and power.',
      name: 'getStrongSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Balanced health and mobility.`
  String get generalFitnessSubtitle {
    return Intl.message(
      'Balanced health and mobility.',
      name: 'generalFitnessSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `RECOMMENDED`
  String get recommendedLabel {
    return Intl.message(
      'RECOMMENDED',
      name: 'recommendedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Optimal recovery cycle`
  String get recommendationRecoveryCycle {
    return Intl.message(
      'Optimal recovery cycle',
      name: 'recommendationRecoveryCycle',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get emailRequiredError {
    return Intl.message(
      'Email is required',
      name: 'emailRequiredError',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email address`
  String get emailInvalidError {
    return Intl.message(
      'Enter a valid email address',
      name: 'emailInvalidError',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get passwordRequiredError {
    return Intl.message(
      'Password is required',
      name: 'passwordRequiredError',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters`
  String get passwordTooShortError {
    return Intl.message(
      'Password must be at least 8 characters',
      name: 'passwordTooShortError',
      desc: '',
      args: [],
    );
  }

  /// `Full name is required`
  String get fullNameRequiredError {
    return Intl.message(
      'Full name is required',
      name: 'fullNameRequiredError',
      desc: '',
      args: [],
    );
  }

  /// `Name must be at least 2 characters`
  String get fullNameTooShortError {
    return Intl.message(
      'Name must be at least 2 characters',
      name: 'fullNameTooShortError',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your password`
  String get confirmPasswordRequiredError {
    return Intl.message(
      'Please confirm your password',
      name: 'confirmPasswordRequiredError',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatchError {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatchError',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Learn`
  String get learn {
    return Intl.message('Learn', name: 'learn', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Summary`
  String get summary {
    return Intl.message('Summary', name: 'summary', desc: '', args: []);
  }

  /// `Activity`
  String get activity {
    return Intl.message('Activity', name: 'activity', desc: '', args: []);
  }

  /// `Vitals`
  String get vitals {
    return Intl.message('Vitals', name: 'vitals', desc: '', args: []);
  }

  /// `Health Profile`
  String get healthProfile {
    return Intl.message(
      'Health Profile',
      name: 'healthProfile',
      desc: '',
      args: [],
    );
  }

  /// `Preferences & Account`
  String get preferencesAccount {
    return Intl.message(
      'Preferences & Account',
      name: 'preferencesAccount',
      desc: '',
      args: [],
    );
  }

  /// `Pro Member Since`
  String get proMemberSince {
    return Intl.message(
      'Pro Member Since',
      name: 'proMemberSince',
      desc: '',
      args: [],
    );
  }

  /// `ACTIVE GOAL`
  String get activeGoal {
    return Intl.message('ACTIVE GOAL', name: 'activeGoal', desc: '', args: []);
  }

  /// `FREQUENCY`
  String get frequency {
    return Intl.message('FREQUENCY', name: 'frequency', desc: '', args: []);
  }

  /// `Legal`
  String get legalLabel {
    return Intl.message('Legal', name: 'legalLabel', desc: '', args: []);
  }

  /// `Profile unavailable. Please sign in again.`
  String get profileUnavailable {
    return Intl.message(
      'Profile unavailable. Please sign in again.',
      name: 'profileUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Build Muscle`
  String get buildMuscle {
    return Intl.message(
      'Build Muscle',
      name: 'buildMuscle',
      desc: '',
      args: [],
    );
  }

  /// `Get Strong`
  String get getStrong {
    return Intl.message('Get Strong', name: 'getStrong', desc: '', args: []);
  }

  /// `General Fitness`
  String get generalFitness {
    return Intl.message(
      'General Fitness',
      name: 'generalFitness',
      desc: '',
      args: [],
    );
  }

  /// `Not Set`
  String get notSet {
    return Intl.message('Not Set', name: 'notSet', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Reset Workout Plan`
  String get resetWorkoutPlan {
    return Intl.message(
      'Reset Workout Plan',
      name: 'resetWorkoutPlan',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get logOut {
    return Intl.message('Log Out', name: 'logOut', desc: '', args: []);
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Service`
  String get termsOfService {
    return Intl.message(
      'Terms of Service',
      name: 'termsOfService',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `Select Language`
  String get selectLanguage {
    return Intl.message(
      'Select Language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Reset`
  String get reset {
    return Intl.message('Reset', name: 'reset', desc: '', args: []);
  }

  /// `Try Again`
  String get tryAgain {
    return Intl.message('Try Again', name: 'tryAgain', desc: '', args: []);
  }

  /// `Log Out`
  String get logOutConfirmTitle {
    return Intl.message(
      'Log Out',
      name: 'logOutConfirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to log out?`
  String get logOutConfirmMessage {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'logOutConfirmMessage',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccountTitle {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccountTitle',
      desc: '',
      args: [],
    );
  }

  /// `This action is permanent and cannot be undone. All your data will be deleted.`
  String get deleteAccountMessage {
    return Intl.message(
      'This action is permanent and cannot be undone. All your data will be deleted.',
      name: 'deleteAccountMessage',
      desc: '',
      args: [],
    );
  }

  /// `Reset Workout Plan`
  String get resetPlanTitle {
    return Intl.message(
      'Reset Workout Plan',
      name: 'resetPlanTitle',
      desc: '',
      args: [],
    );
  }

  /// `This will reset your goals and restart the onboarding flow.`
  String get resetPlanMessage {
    return Intl.message(
      'This will reset your goals and restart the onboarding flow.',
      name: 'resetPlanMessage',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Your Identity`
  String get reauthTitle {
    return Intl.message(
      'Confirm Your Identity',
      name: 'reauthTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password to confirm account deletion.`
  String get reauthMessage {
    return Intl.message(
      'Please enter your password to confirm account deletion.',
      name: 'reauthMessage',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordLabel {
    return Intl.message('Password', name: 'passwordLabel', desc: '', args: []);
  }

  /// `Error`
  String get errorLabel {
    return Intl.message('Error', name: 'errorLabel', desc: '', args: []);
  }

  /// `Today's Workout`
  String get todayWorkout {
    return Intl.message(
      'Today\'s Workout',
      name: 'todayWorkout',
      desc: '',
      args: [],
    );
  }

  /// `Rest Day`
  String get restDay {
    return Intl.message('Rest Day', name: 'restDay', desc: '', args: []);
  }

  /// `Weekly Blueprint`
  String get weeklyBlueprint {
    return Intl.message(
      'Weekly Blueprint',
      name: 'weeklyBlueprint',
      desc: '',
      args: [],
    );
  }

  /// `Start Workout  ▶`
  String get startWorkout {
    return Intl.message(
      'Start Workout  ▶',
      name: 'startWorkout',
      desc: '',
      args: [],
    );
  }

  /// `Exercises`
  String get exercises {
    return Intl.message('Exercises', name: 'exercises', desc: '', args: []);
  }

  /// `Sets`
  String get sets {
    return Intl.message('Sets', name: 'sets', desc: '', args: []);
  }

  /// `Reps`
  String get reps {
    return Intl.message('Reps', name: 'reps', desc: '', args: []);
  }

  /// `ACTIVE PLAN`
  String get activePlan {
    return Intl.message('ACTIVE PLAN', name: 'activePlan', desc: '', args: []);
  }

  /// `Today's Exercises`
  String get todayExercises {
    return Intl.message(
      'Today\'s Exercises',
      name: 'todayExercises',
      desc: '',
      args: [],
    );
  }

  /// `Minutes`
  String get minutes {
    return Intl.message('Minutes', name: 'minutes', desc: '', args: []);
  }

  /// `Recovery`
  String get recovery {
    return Intl.message('Recovery', name: 'recovery', desc: '', args: []);
  }

  /// `Weekly Burn`
  String get weeklyBurn {
    return Intl.message('Weekly Burn', name: 'weeklyBurn', desc: '', args: []);
  }

  /// `kcal`
  String get kcal {
    return Intl.message('kcal', name: 'kcal', desc: '', args: []);
  }

  /// `Let's get to work.`
  String get letsGetToWork {
    return Intl.message(
      'Let\'s get to work.',
      name: 'letsGetToWork',
      desc: '',
      args: [],
    );
  }

  /// `Rest & recover today.`
  String get letsRestToday {
    return Intl.message(
      'Rest & recover today.',
      name: 'letsRestToday',
      desc: '',
      args: [],
    );
  }

  /// `Weight`
  String get weight {
    return Intl.message('Weight', name: 'weight', desc: '', args: []);
  }

  /// `kg`
  String get kg {
    return Intl.message('kg', name: 'kg', desc: '', args: []);
  }

  /// `No workout plan found.`
  String get noWorkoutPlan {
    return Intl.message(
      'No workout plan found.',
      name: 'noWorkoutPlan',
      desc: '',
      args: [],
    );
  }

  /// `Good morning`
  String get goodMorning {
    return Intl.message(
      'Good morning',
      name: 'goodMorning',
      desc: '',
      args: [],
    );
  }

  /// `Good afternoon`
  String get goodAfternoon {
    return Intl.message(
      'Good afternoon',
      name: 'goodAfternoon',
      desc: '',
      args: [],
    );
  }

  /// `Good evening`
  String get goodEvening {
    return Intl.message(
      'Good evening',
      name: 'goodEvening',
      desc: '',
      args: [],
    );
  }

  /// `Let's get moving!`
  String get letsGetMoving {
    return Intl.message(
      'Let\'s get moving!',
      name: 'letsGetMoving',
      desc: '',
      args: [],
    );
  }

  /// `Take it easy today.`
  String get restDayMessage {
    return Intl.message(
      'Take it easy today.',
      name: 'restDayMessage',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get finishExercise {
    return Intl.message('Finish', name: 'finishExercise', desc: '', args: []);
  }

  /// `+ ADD SET`
  String get addSet {
    return Intl.message('+ ADD SET', name: 'addSet', desc: '', args: []);
  }

  /// `FORM CUES`
  String get formCues {
    return Intl.message('FORM CUES', name: 'formCues', desc: '', args: []);
  }

  /// `Elapsed`
  String get elapsedTime {
    return Intl.message('Elapsed', name: 'elapsedTime', desc: '', args: []);
  }

  /// `SET`
  String get setNumber {
    return Intl.message('SET', name: 'setNumber', desc: '', args: []);
  }

  /// `WEIGHT`
  String get weightHeader {
    return Intl.message('WEIGHT', name: 'weightHeader', desc: '', args: []);
  }

  /// `REPS`
  String get repsHeader {
    return Intl.message('REPS', name: 'repsHeader', desc: '', args: []);
  }

  /// `DONE`
  String get doneHeader {
    return Intl.message('DONE', name: 'doneHeader', desc: '', args: []);
  }

  /// `Done`
  String get done {
    return Intl.message('Done', name: 'done', desc: '', args: []);
  }

  /// `Previous`
  String get previous {
    return Intl.message('Previous', name: 'previous', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Workout Session`
  String get workoutSession {
    return Intl.message(
      'Workout Session',
      name: 'workoutSession',
      desc: '',
      args: [],
    );
  }

  /// `Start Rest Timer`
  String get startRestTimer {
    return Intl.message(
      'Start Rest Timer',
      name: 'startRestTimer',
      desc: '',
      args: [],
    );
  }

  /// `Complete all sets before continuing.`
  String get validationCompleteAllSets {
    return Intl.message(
      'Complete all sets before continuing.',
      name: 'validationCompleteAllSets',
      desc: '',
      args: [],
    );
  }

  /// `Each set needs at least 1 kg.`
  String get validationAddWeight {
    return Intl.message(
      'Each set needs at least 1 kg.',
      name: 'validationAddWeight',
      desc: '',
      args: [],
    );
  }

  /// `Enter Starting Weight`
  String get startingWeight {
    return Intl.message(
      'Enter Starting Weight',
      name: 'startingWeight',
      desc: '',
      args: [],
    );
  }

  /// `Don't worry, you can update this later whenever you want.`
  String get startingWeightSubtitle {
    return Intl.message(
      'Don\'t worry, you can update this later whenever you want.',
      name: 'startingWeightSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Save & Start`
  String get saveAndStart {
    return Intl.message(
      'Save & Start',
      name: 'saveAndStart',
      desc: '',
      args: [],
    );
  }

  /// `Not sure? Use default`
  String get useDefault {
    return Intl.message(
      'Not sure? Use default',
      name: 'useDefault',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get saveWeight {
    return Intl.message('Save', name: 'saveWeight', desc: '', args: []);
  }

  /// `Skip`
  String get skipWeight {
    return Intl.message('Skip', name: 'skipWeight', desc: '', args: []);
  }

  /// `{n} Days/Week`
  String daysPerWeek(int n) {
    return Intl.message(
      '$n Days/Week',
      name: 'daysPerWeek',
      desc: '',
      args: [n],
    );
  }

  /// `{n, select, 5{5+ Days} other{{n} Days}}`
  String availabilityDaysOption(String n) {
    return Intl.message(
      '{n, select, 5{5+ Days} other{$n Days}}',
      name: 'availabilityDaysOption',
      desc: '',
      args: [n],
    );
  }

  /// `Version {v}`
  String appVersion(String v) {
    return Intl.message('Version $v', name: 'appVersion', desc: '', args: [v]);
  }

  /// `Week {n}`
  String weekLabel(int n) {
    return Intl.message('Week $n', name: 'weekLabel', desc: '', args: [n]);
  }

  /// `{n, plural, one{1 exercise} other{{n} exercises}}`
  String exerciseCount(int n) {
    return Intl.plural(
      n,
      one: '1 exercise',
      other: '$n exercises',
      name: 'exerciseCount',
      desc: '',
      args: [n],
    );
  }

  /// `{n, plural, one{1 set} other{{n} sets}}`
  String setCount(int n) {
    return Intl.plural(
      n,
      one: '1 set',
      other: '$n sets',
      name: 'setCount',
      desc: '',
      args: [n],
    );
  }

  /// `Pro Member Since {monthYear}`
  String memberSince(String monthYear) {
    return Intl.message(
      'Pro Member Since $monthYear',
      name: 'memberSince',
      desc: '',
      args: [monthYear],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
