import 'package:fit_flow/core/utils/app_navigation.dart';
import 'package:flutter/material.dart';

void main() {
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
