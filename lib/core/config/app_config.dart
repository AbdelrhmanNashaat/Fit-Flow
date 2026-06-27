import 'package:fit_flow/core/config/app_environment.dart';
import 'package:flutter/foundation.dart';

class AppConfig {
  AppConfig._();

  static const String appName = 'FitFlow';
  static bool get showDebugBanner => kDebugMode;
  static String get googleServerClientId => AppEnvironment.googleServerClientId;
  static bool get enableVerboseAuthLogs => AppEnvironment.enableVerboseAuthLogs;
  static bool get hasGoogleServerClientId => googleServerClientId.isNotEmpty;
}
