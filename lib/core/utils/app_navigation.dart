import 'package:fit_flow/features/splash/splash_view.dart';
import 'package:flutter/material.dart';
import '../../features/auth/presentation/views/sign_up_view.dart';

class AppNavigation {
  static const String splash = '/';
  static const String signUp = '/signUp';
  static const String signIn = '/signIn';
  static const String forgotPassword = '/forgotPassword';
  static Map<String, Widget Function(BuildContext)> routes =
      <String, WidgetBuilder>{
        splash: (BuildContext context) => const SplashView(),
        signUp: (BuildContext context) => const SignUpView(),
      };
}
