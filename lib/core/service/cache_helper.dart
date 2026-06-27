import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  CacheHelper._(this._preferences, this._secureStorage);

  static Future<CacheHelper> init() async {
    final preferences = await SharedPreferences.getInstance();
    const secureStorage = FlutterSecureStorage();
    return CacheHelper._(preferences, secureStorage);
  }

  static const _authUserKey = 'auth_user';
  static const _localeKey = 'app_locale';
  static const _hasSelectedLanguageKey = 'has_selected_language';
  static const _localImagePathPrefix = 'local_image_path_';
  static const _profilePrefix = 'user_profile_';

  final SharedPreferences _preferences;
  final FlutterSecureStorage _secureStorage;

  String? get savedLocale => _preferences.getString(_localeKey);

  /// True only after the user explicitly completes the first-run language
  /// setup screen. Uses a dedicated key so it is never accidentally set by
  /// the profile language toggle or any previous app version.
  bool get hasLanguageBeenSelected =>
      _preferences.getBool(_hasSelectedLanguageKey) == true;

  Future<void> markLanguageSetupDone() async {
    await _preferences.setBool(_hasSelectedLanguageKey, true);
  }

  Future<Map<String, dynamic>?> getCachedUserJson() async {
    final raw = await _secureStorage.read(key: _authUserKey);
    if (raw == null || raw.isEmpty) return null;
    try {
      return jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  Future<void> cacheUserJson(Map<String, dynamic> json) async {
    await _secureStorage.write(key: _authUserKey, value: jsonEncode(json));
  }

  Future<void> clearAuthData() async {
    await _secureStorage.delete(key: _authUserKey);
    final entries = await _secureStorage.readAll();
    for (final key in entries.keys.where(
      (key) => key.startsWith(_profilePrefix),
    )) {
      await _secureStorage.delete(key: key);
    }
  }

  Future<void> saveLocale(String languageCode) async {
    await _preferences.setString(_localeKey, languageCode);
  }

  String? getLocalImagePath(String uid) =>
      _preferences.getString('$_localImagePathPrefix$uid');

  Future<void> saveLocalImagePath(String uid, String path) async {
    await _preferences.setString('$_localImagePathPrefix$uid', path);
  }

  Future<Map<String, dynamic>?> getCachedProfileJson(String uid) async {
    final raw = await _secureStorage.read(key: '$_profilePrefix$uid');
    if (raw == null || raw.isEmpty) return null;
    try {
      return jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  Future<void> cacheProfileJson(String uid, Map<String, dynamic> json) async {
    await _secureStorage.write(
      key: '$_profilePrefix$uid',
      value: jsonEncode(json),
    );
  }

  Future<void> clearProfileCache(String uid) async {
    await _secureStorage.delete(key: '$_profilePrefix$uid');
  }
}
