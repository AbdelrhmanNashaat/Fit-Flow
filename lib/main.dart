import 'package:fit_flow/core/config/app_config.dart';
import 'package:fit_flow/core/config/app_flavor.dart';
import 'package:fit_flow/fit_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fit_flow/core/bootstrap/app_bootstrap.dart';

Future<void> main() async {
  AppConfig.setup(AppFlavor.production);
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await AppBootstrap.init();
  runApp(const FitFlow());
}
