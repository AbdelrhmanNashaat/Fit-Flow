import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  CacheHelper(this._preferences);

  static const _authUserKey = 'auth_user';
  static const _isLoggedInKey = 'is_logged_in';
  static const _localeKey = 'app_locale';
  static const _localImagePathPrefix = 'local_image_path_';
  static const _profilePrefix = 'user_profile_';

  final SharedPreferences _preferences;

  bool get isLoggedIn => _preferences.getBool(_isLoggedInKey) ?? false;

  String? get savedLocale => _preferences.getString(_localeKey);

  Map<String, dynamic>? getCachedUserJson() {
    final raw = _preferences.getString(_authUserKey);
    if (raw == null || raw.isEmpty) return null;
    try {
      return jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  Future<void> cacheUserJson(Map<String, dynamic> json) async {
    await _preferences.setString(_authUserKey, jsonEncode(json));
    await _preferences.setBool(_isLoggedInKey, true);
  }

  Future<void> clearAuthData() async {
    await _preferences.remove(_authUserKey);
    await _preferences.setBool(_isLoggedInKey, false);
  }

  Future<void> saveLocale(String languageCode) async {
    await _preferences.setString(_localeKey, languageCode);
  }

  String? getLocalImagePath(String uid) =>
      _preferences.getString('$_localImagePathPrefix$uid');

  Future<void> saveLocalImagePath(String uid, String path) async {
    await _preferences.setString('$_localImagePathPrefix$uid', path);
  }

  Map<String, dynamic>? getCachedProfileJson(String uid) {
    final raw = _preferences.getString('$_profilePrefix$uid');
    if (raw == null || raw.isEmpty) return null;
    try {
      return jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  Future<void> cacheProfileJson(String uid, Map<String, dynamic> json) async {
    await _preferences.setString('$_profilePrefix$uid', jsonEncode(json));
  }

  Future<void> clearProfileCache(String uid) async {
    await _preferences.remove('$_profilePrefix$uid');
  }
}
