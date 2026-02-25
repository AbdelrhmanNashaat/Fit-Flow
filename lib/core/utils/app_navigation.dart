import 'package:flutter/material.dart';
import '../../features/sign_up/presentation/views/sign_up_view.dart';
import '../../features/splash/splash_view.dart';

class AppNavigation {
  static const String splash = '/';
  static const String signUp = '/signUp';
  static const String signIn = '/signIn';
  static const String forgotPassword = '/forgotPassword';
  static Map<String, Widget Function(BuildContext)> routes =
      <String, WidgetBuilder>{
        splash: (context) => const SplashView(),
        signUp: (context) => const SignUpView(),
        signIn: (context) => const SplashView(),
        forgotPassword: (context) => const SplashView(),
      };
}
