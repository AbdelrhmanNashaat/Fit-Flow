import 'package:fit_flow/core/config/app_flavor.dart';

class AppConfig {
  const AppConfig._({
    required this.flavor,
    required this.appName,
    required this.showDebugBanner,
    required this.googleServerClientId,
  });
  final AppFlavor flavor;
  final String appName;
  final bool showDebugBanner;
  final String googleServerClientId;

  static late final AppConfig _instance;

  static AppConfig get instance => _instance;

  static void setup(AppFlavor flavor) {
    switch (flavor) {
      case AppFlavor.development:
        _instance = const AppConfig._(
          flavor: AppFlavor.development,
          appName: 'FitFlow Dev',
          showDebugBanner: true,
          googleServerClientId:
              '528662074916-djltr29g5njdrqonqkfnlguar43jllam.apps.googleusercontent.com',
        );
      case AppFlavor.staging:
        _instance = const AppConfig._(
          flavor: AppFlavor.staging,
          appName: 'FitFlow Staging',
          showDebugBanner: true,
          googleServerClientId:
              '528662074916-djltr29g5njdrqonqkfnlguar43jllam.apps.googleusercontent.com',
        );
      case AppFlavor.production:
        _instance = const AppConfig._(
          flavor: AppFlavor.production,
          appName: 'FitFlow',
          showDebugBanner: false,
          googleServerClientId:
              '528662074916-djltr29g5njdrqonqkfnlguar43jllam.apps.googleusercontent.com',
        );
    }
  }

  bool get isDevelopment => flavor == AppFlavor.development;
  bool get isStaging => flavor == AppFlavor.staging;
  bool get isProduction => flavor == AppFlavor.production;
}
