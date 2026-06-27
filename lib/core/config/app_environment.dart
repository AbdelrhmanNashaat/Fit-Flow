import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnvironment {
  static bool _isLoaded = false;

  static Future<void> load() async {
    if (_isLoaded) {
      return;
    }

    await dotenv.load(fileName: '.env', isOptional: true);
    _isLoaded = true;
  }

  static String get googleServerClientId =>
      dotenv.env['GOOGLE_SERVER_CLIENT_ID']?.trim() ?? '';

  static bool get enableVerboseAuthLogs =>
      _boolFromEnv('ENABLE_VERBOSE_AUTH_LOGS');

  static bool _boolFromEnv(String key, {bool defaultValue = false}) {
    final rawValue = dotenv.env[key]?.trim().toLowerCase();

    return switch (rawValue) {
      '1' || 'true' || 'yes' || 'on' => true,
      '0' || 'false' || 'no' || 'off' => false,
      _ => defaultValue,
    };
  }
}
