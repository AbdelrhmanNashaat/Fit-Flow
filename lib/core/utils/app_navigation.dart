import 'package:flutter/material.dart';
import '../../features/auth/presentation/views/sign_up_view.dart';

class AppNavigation {
  static const String signUp = '/signUp';
  static const String signIn = '/signIn';
  static const String forgotPassword = '/forgotPassword';
  static Map<String, Widget Function(BuildContext)> routes =
      <String, WidgetBuilder>{
        signUp: (BuildContext context) => const SignUpView(),
      };
}
