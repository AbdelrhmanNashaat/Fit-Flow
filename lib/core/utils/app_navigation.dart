import 'package:fit_flow/features/auth/presentation/views/create_account_view.dart';
import 'package:fit_flow/features/auth/presentation/views/forgot_password_view.dart';
import 'package:fit_flow/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:fit_flow/features/splash/presentation/views/splash_view.dart';
import 'package:fit_flow/features/main/presentation/views/main_view.dart';
import 'package:flutter/material.dart';
import 'package:fit_flow/features/auth/presentation/views/sign_in_view.dart';

class AppNavigation {
  static const String splash = '/';
  static const String signUp = '/signUp';
  static const String signIn = '/signIn';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String forgotPassword = '/forgotPassword';
  static Map<String, Widget Function(BuildContext)> routes =
      <String, WidgetBuilder>{
        splash: (BuildContext context) => const SplashView(),
        signIn: (BuildContext context) => const SignInView(),
        signUp: (BuildContext context) => const CreateAccountView(),
        onboarding: (BuildContext context) => const OnboardingView(),
        home: (BuildContext context) => const MainView(),
        forgotPassword: (BuildContext context) => const ForgotPasswordView(),
      };
}
