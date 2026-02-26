import 'package:fit_flow/core/utils/app_navigation.dart';
import 'package:flutter/material.dart';
import 'core/service/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupServiceLocator();
  runApp(const FitFlow());
}

class FitFlow extends StatelessWidget {
  const FitFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppNavigation.splash,
      routes: AppNavigation.routes,
    );
  }
}
