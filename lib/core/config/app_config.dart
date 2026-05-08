import 'package:fit_flow/core/config/app_flavor.dart';
import 'package:fit_flow/core/config/app_environment.dart';

class AppConfig {
  const AppConfig._({
    required this.flavor,
    required this.appName,
    required this.showDebugBanner,
    required this.googleServerClientId,
    required this.apiBaseUrl,
    required this.enableVerboseAuthLogs,
  });
  final AppFlavor flavor;
  final String appName;
  final bool showDebugBanner;
  final String googleServerClientId;
  final String apiBaseUrl;
  final bool enableVerboseAuthLogs;

  static late final AppConfig _instance;

  static AppConfig get instance => _instance;

  static void setup(AppFlavor flavor) {
    switch (flavor) {
      case AppFlavor.development:
        _instance = AppConfig._(
          flavor: AppFlavor.development,
          appName: 'FitFlow Dev',
          showDebugBanner: true,
          googleServerClientId: AppEnvironment.googleServerClientId,
          apiBaseUrl: AppEnvironment.apiBaseUrl,
          enableVerboseAuthLogs: AppEnvironment.enableVerboseAuthLogs,
        );
      case AppFlavor.staging:
        _instance = AppConfig._(
          flavor: AppFlavor.staging,
          appName: 'FitFlow Staging',
          showDebugBanner: true,
          googleServerClientId: AppEnvironment.googleServerClientId,
          apiBaseUrl: AppEnvironment.apiBaseUrl,
          enableVerboseAuthLogs: AppEnvironment.enableVerboseAuthLogs,
        );
      case AppFlavor.production:
        _instance = AppConfig._(
          flavor: AppFlavor.production,
          appName: 'FitFlow',
          showDebugBanner: false,
          googleServerClientId: AppEnvironment.googleServerClientId,
          apiBaseUrl: AppEnvironment.apiBaseUrl,
          enableVerboseAuthLogs: AppEnvironment.enableVerboseAuthLogs,
        );
    }
  }

  bool get isDevelopment => flavor == AppFlavor.development;
  bool get isStaging => flavor == AppFlavor.staging;
  bool get isProduction => flavor == AppFlavor.production;
  bool get hasGoogleServerClientId => googleServerClientId.isNotEmpty;
}
