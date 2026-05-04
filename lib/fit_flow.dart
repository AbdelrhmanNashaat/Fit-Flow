import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:fit_flow/core/utils/app_navigation.dart';

class FitFlow extends StatefulWidget {
  const FitFlow({super.key});

  @override
  State<FitFlow> createState() => _FitFlowState();
}

class _FitFlowState extends State<FitFlow> {
  @override
  void initState() {
    super.initState();

    _removeSplash();
  }

  void _removeSplash() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppNavigation.signUp,
      routes: AppNavigation.routes,
    );
  }
}
