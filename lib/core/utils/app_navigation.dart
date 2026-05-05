import 'package:fit_flow/features/auth/presentation/views/create_account_view.dart';
import 'package:fit_flow/features/home/presentation/views/home_view.dart';
import 'package:fit_flow/features/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:fit_flow/features/auth/presentation/views/sign_in_view.dart';

class AppNavigation {
  static const String splash = '/';
  static const String signUp = '/signUp';
  static const String signIn = '/signIn';
  static const String home = '/home';
  static const String forgotPassword = '/forgotPassword';
  static Map<String, Widget Function(BuildContext)> routes =
      <String, WidgetBuilder>{
        splash: (BuildContext context) => const SplashView(),
        signIn: (BuildContext context) => const SignInView(),
        signUp: (BuildContext context) => const CreateAccountView(),
        home: (BuildContext context) => const HomeView(),
      };
}
