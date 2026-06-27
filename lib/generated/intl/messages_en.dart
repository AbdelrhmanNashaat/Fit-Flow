// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(v) => "Version ${v}";

  static String m1(n) => "{n, select, 5{5+ Days} other{${n} Days}}";

  static String m2(n) => "${n} Days/Week";

  static String m3(n) =>
      "${Intl.plural(n, one: '1 exercise', other: '${n} exercises')}";

  static String m4(monthYear) => "Pro Member Since ${monthYear}";

  static String m5(n) => "${Intl.plural(n, one: '1 set', other: '${n} sets')}";

  static String m6(n) => "Week ${n}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "activeGoal": MessageLookupByLibrary.simpleMessage("ACTIVE GOAL"),
    "activePlan": MessageLookupByLibrary.simpleMessage("ACTIVE PLAN"),
    "activity": MessageLookupByLibrary.simpleMessage("Activity"),
    "addSet": MessageLookupByLibrary.simpleMessage("+ ADD SET"),
    "alreadyHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Already have an account?",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("FitFlow"),
    "appVersion": m0,
    "apple": MessageLookupByLibrary.simpleMessage("Apple"),
    "arabic": MessageLookupByLibrary.simpleMessage("Arabic"),
    "authBrandName": MessageLookupByLibrary.simpleMessage("FitFlow Pure"),
    "availabilityDaysOption": m1,
    "backToSignIn": MessageLookupByLibrary.simpleMessage("Back to Sign In"),
    "buildMuscle": MessageLookupByLibrary.simpleMessage("Build Muscle"),
    "buildMuscleSubtitle": MessageLookupByLibrary.simpleMessage(
      "Focus on hypertrophy and strength.",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "checkYourInbox": MessageLookupByLibrary.simpleMessage("Check Your Inbox"),
    "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "confirmPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Confirm Password",
    ),
    "confirmPasswordRequiredError": MessageLookupByLibrary.simpleMessage(
      "Please confirm your password",
    ),
    "createAccount": MessageLookupByLibrary.simpleMessage("Create Account"),
    "createAccountNav": MessageLookupByLibrary.simpleMessage(
      "Create an account",
    ),
    "createAccountSubtitle": MessageLookupByLibrary.simpleMessage(
      "Create your account to get started.",
    ),
    "daysPerWeek": m2,
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteAccount": MessageLookupByLibrary.simpleMessage("Delete Account"),
    "deleteAccountMessage": MessageLookupByLibrary.simpleMessage(
      "This action is permanent and cannot be undone. All your data will be deleted.",
    ),
    "deleteAccountTitle": MessageLookupByLibrary.simpleMessage(
      "Delete Account",
    ),
    "done": MessageLookupByLibrary.simpleMessage("Done"),
    "doneHeader": MessageLookupByLibrary.simpleMessage("DONE"),
    "elapsedTime": MessageLookupByLibrary.simpleMessage("Elapsed"),
    "emailAddressLabel": MessageLookupByLibrary.simpleMessage("Email Address"),
    "emailInvalidError": MessageLookupByLibrary.simpleMessage(
      "Enter a valid email address",
    ),
    "emailRequiredError": MessageLookupByLibrary.simpleMessage(
      "Email is required",
    ),
    "english": MessageLookupByLibrary.simpleMessage("English"),
    "errorLabel": MessageLookupByLibrary.simpleMessage("Error"),
    "exerciseCount": m3,
    "exercises": MessageLookupByLibrary.simpleMessage("Exercises"),
    "finishExercise": MessageLookupByLibrary.simpleMessage("Finish"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Forgot Password?"),
    "forgotPasswordDescription": MessageLookupByLibrary.simpleMessage(
      "Enter the email linked to your account and we\'ll send you a reset link.",
    ),
    "formCues": MessageLookupByLibrary.simpleMessage("FORM CUES"),
    "frequency": MessageLookupByLibrary.simpleMessage("FREQUENCY"),
    "fullNameLabel": MessageLookupByLibrary.simpleMessage("Full Name"),
    "fullNameRequiredError": MessageLookupByLibrary.simpleMessage(
      "Full name is required",
    ),
    "fullNameTooShortError": MessageLookupByLibrary.simpleMessage(
      "Name must be at least 2 characters",
    ),
    "generalFitness": MessageLookupByLibrary.simpleMessage("General Fitness"),
    "generalFitnessSubtitle": MessageLookupByLibrary.simpleMessage(
      "Balanced health and mobility.",
    ),
    "getStrong": MessageLookupByLibrary.simpleMessage("Get Strong"),
    "getStrongSubtitle": MessageLookupByLibrary.simpleMessage(
      "Prioritize heavy lifting and power.",
    ),
    "goodAfternoon": MessageLookupByLibrary.simpleMessage("Good afternoon"),
    "goodEvening": MessageLookupByLibrary.simpleMessage("Good evening"),
    "goodMorning": MessageLookupByLibrary.simpleMessage("Good morning"),
    "google": MessageLookupByLibrary.simpleMessage("Google"),
    "healthProfile": MessageLookupByLibrary.simpleMessage("Health Profile"),
    "home": MessageLookupByLibrary.simpleMessage("Home"),
    "kcal": MessageLookupByLibrary.simpleMessage("kcal"),
    "kg": MessageLookupByLibrary.simpleMessage("kg"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "learn": MessageLookupByLibrary.simpleMessage("Learn"),
    "legalLabel": MessageLookupByLibrary.simpleMessage("Legal"),
    "letsGetMoving": MessageLookupByLibrary.simpleMessage("Let\'s get moving!"),
    "letsGetToWork": MessageLookupByLibrary.simpleMessage(
      "Let\'s get to work.",
    ),
    "letsRestToday": MessageLookupByLibrary.simpleMessage(
      "Rest & recover today.",
    ),
    "logOut": MessageLookupByLibrary.simpleMessage("Log Out"),
    "logOutConfirmMessage": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to log out?",
    ),
    "logOutConfirmTitle": MessageLookupByLibrary.simpleMessage("Log Out"),
    "memberSince": m4,
    "minutes": MessageLookupByLibrary.simpleMessage("Minutes"),
    "newToFitFlow": MessageLookupByLibrary.simpleMessage("New to FitFlow?"),
    "next": MessageLookupByLibrary.simpleMessage("Next"),
    "noWorkoutPlan": MessageLookupByLibrary.simpleMessage(
      "No workout plan found.",
    ),
    "notSet": MessageLookupByLibrary.simpleMessage("Not Set"),
    "onboardingAvailabilityTitle": MessageLookupByLibrary.simpleMessage(
      "Weekly Availability",
    ),
    "onboardingChangeLater": MessageLookupByLibrary.simpleMessage(
      "YOU CAN CHANGE THIS LATER IN PROFILE",
    ),
    "onboardingContinue": MessageLookupByLibrary.simpleMessage("Continue"),
    "onboardingSubtitle": MessageLookupByLibrary.simpleMessage(
      "Customize your journey for precision performance.",
    ),
    "onboardingTitle": MessageLookupByLibrary.simpleMessage("Select Your Goal"),
    "orContinueWith": MessageLookupByLibrary.simpleMessage("or continue with"),
    "passwordLabel": MessageLookupByLibrary.simpleMessage("Password"),
    "passwordRequiredError": MessageLookupByLibrary.simpleMessage(
      "Password is required",
    ),
    "passwordTooShortError": MessageLookupByLibrary.simpleMessage(
      "Password must be at least 8 characters",
    ),
    "passwordsDoNotMatchError": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match",
    ),
    "preferencesAccount": MessageLookupByLibrary.simpleMessage(
      "Preferences & Account",
    ),
    "previous": MessageLookupByLibrary.simpleMessage("Previous"),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "proMemberSince": MessageLookupByLibrary.simpleMessage("Pro Member Since"),
    "profile": MessageLookupByLibrary.simpleMessage("Profile"),
    "profileUnavailable": MessageLookupByLibrary.simpleMessage(
      "Profile unavailable. Please sign in again.",
    ),
    "reauthMessage": MessageLookupByLibrary.simpleMessage(
      "Please enter your password to confirm account deletion.",
    ),
    "reauthTitle": MessageLookupByLibrary.simpleMessage(
      "Confirm Your Identity",
    ),
    "recommendationRecoveryCycle": MessageLookupByLibrary.simpleMessage(
      "Optimal recovery cycle",
    ),
    "recommendedLabel": MessageLookupByLibrary.simpleMessage("RECOMMENDED"),
    "recovery": MessageLookupByLibrary.simpleMessage("Recovery"),
    "reps": MessageLookupByLibrary.simpleMessage("Reps"),
    "repsHeader": MessageLookupByLibrary.simpleMessage("REPS"),
    "reset": MessageLookupByLibrary.simpleMessage("Reset"),
    "resetLinkSentBody": MessageLookupByLibrary.simpleMessage(
      "If an account exists for this email, you\'ll receive a password reset link shortly.",
    ),
    "resetPlanMessage": MessageLookupByLibrary.simpleMessage(
      "This will reset your goals and restart the onboarding flow.",
    ),
    "resetPlanTitle": MessageLookupByLibrary.simpleMessage(
      "Reset Workout Plan",
    ),
    "resetWorkoutPlan": MessageLookupByLibrary.simpleMessage(
      "Reset Workout Plan",
    ),
    "restDay": MessageLookupByLibrary.simpleMessage("Rest Day"),
    "restDayMessage": MessageLookupByLibrary.simpleMessage(
      "Take it easy today.",
    ),
    "saveAndStart": MessageLookupByLibrary.simpleMessage("Save & Start"),
    "saveWeight": MessageLookupByLibrary.simpleMessage("Save"),
    "selectLanguage": MessageLookupByLibrary.simpleMessage("Select Language"),
    "sendResetLink": MessageLookupByLibrary.simpleMessage("Send Reset Link"),
    "setCount": m5,
    "setNumber": MessageLookupByLibrary.simpleMessage("SET"),
    "sets": MessageLookupByLibrary.simpleMessage("Sets"),
    "signIn": MessageLookupByLibrary.simpleMessage("Sign In"),
    "signInNav": MessageLookupByLibrary.simpleMessage("Sign in"),
    "skipWeight": MessageLookupByLibrary.simpleMessage("Skip"),
    "splashTagline": MessageLookupByLibrary.simpleMessage(
      "Elevate Your Movement",
    ),
    "startRestTimer": MessageLookupByLibrary.simpleMessage("Start Rest Timer"),
    "startWorkout": MessageLookupByLibrary.simpleMessage("Start Workout  ▶"),
    "startingWeight": MessageLookupByLibrary.simpleMessage(
      "Enter Starting Weight",
    ),
    "startingWeightSubtitle": MessageLookupByLibrary.simpleMessage(
      "Don\'t worry, you can update this later whenever you want.",
    ),
    "summary": MessageLookupByLibrary.simpleMessage("Summary"),
    "termsAndPrivacyLabel": MessageLookupByLibrary.simpleMessage(
      "Terms of Use  ·  Privacy Policy",
    ),
    "termsOfService": MessageLookupByLibrary.simpleMessage("Terms of Service"),
    "todayExercises": MessageLookupByLibrary.simpleMessage(
      "Today\'s Exercises",
    ),
    "todayWorkout": MessageLookupByLibrary.simpleMessage("Today\'s Workout"),
    "tryAgain": MessageLookupByLibrary.simpleMessage("Try Again"),
    "useDefault": MessageLookupByLibrary.simpleMessage("Not sure? Use default"),
    "validationAddWeight": MessageLookupByLibrary.simpleMessage(
      "Each set needs at least 1 kg.",
    ),
    "validationCompleteAllSets": MessageLookupByLibrary.simpleMessage(
      "Complete all sets before continuing.",
    ),
    "vitals": MessageLookupByLibrary.simpleMessage("Vitals"),
    "weekLabel": m6,
    "weeklyBlueprint": MessageLookupByLibrary.simpleMessage("Weekly Blueprint"),
    "weeklyBurn": MessageLookupByLibrary.simpleMessage("Weekly Burn"),
    "weight": MessageLookupByLibrary.simpleMessage("Weight"),
    "weightHeader": MessageLookupByLibrary.simpleMessage("WEIGHT"),
    "welcomeBackSubtitle": MessageLookupByLibrary.simpleMessage(
      "Welcome back. Let\'s keep moving.",
    ),
    "workoutSession": MessageLookupByLibrary.simpleMessage("Workout Session"),
  };
}
