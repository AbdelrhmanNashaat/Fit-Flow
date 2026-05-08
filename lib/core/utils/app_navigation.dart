import 'package:fit_flow/features/auth/presentation/views/create_account_view.dart';
import 'package:fit_flow/features/auth/presentation/views/forgot_password_view.dart';
import 'package:fit_flow/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:fit_flow/features/splash/presentation/views/splash_view.dart';
import 'package:fit_flow/features/main/presentation/views/main_view.dart';
import 'package:fit_flow/features/workout/presentation/views/active_exercise_view.dart';
import 'package:flutter/material.dart';
import 'package:fit_flow/features/auth/presentation/views/sign_in_view.dart';

class AppNavigation {
  static const String splash = '/';
  static const String signUp = '/signUp';
  static const String signIn = '/signIn';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String forgotPassword = '/forgotPassword';
  static const String activeExercise = '/activeExercise';

  static final Map<String, WidgetBuilder> routes =
      Map.unmodifiable(<String, WidgetBuilder>{
        splash: (_) => const SplashView(),
        signIn: (_) => const SignInView(),
        signUp: (_) => const CreateAccountView(),
        onboarding: (_) => const OnboardingView(),
        home: (_) => const MainView(),
        forgotPassword: (_) => const ForgotPasswordView(),
        activeExercise: (_) => const ActiveExerciseView(),
      });
}
