import 'app_flavor.dart';

class AppConfig {
  final AppFlavor flavor;
  final String appName;
  final bool showDebugBanner;

  const AppConfig._({
    required this.flavor,
    required this.appName,
    required this.showDebugBanner,
  });

  static late final AppConfig _instance;

  static AppConfig get instance => _instance;

  static void setup(AppFlavor flavor) {
    switch (flavor) {
      case AppFlavor.development:
        _instance = const AppConfig._(
          flavor: AppFlavor.development,
          appName: 'FitFlow Dev',
          showDebugBanner: true,
        );
      case AppFlavor.staging:
        _instance = const AppConfig._(
          flavor: AppFlavor.staging,
          appName: 'FitFlow Staging',
          showDebugBanner: true,
        );
      case AppFlavor.production:
        _instance = const AppConfig._(
          flavor: AppFlavor.production,
          appName: 'FitFlow',
          showDebugBanner: false,
        );
    }
  }

  bool get isDevelopment => flavor == AppFlavor.development;
  bool get isStaging => flavor == AppFlavor.staging;
  bool get isProduction => flavor == AppFlavor.production;
}
