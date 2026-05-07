import 'dart:convert';

import 'package:fit_flow/features/auth/data/model/auth_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  CacheHelper(this._preferences);

  static const _authUserKey = 'auth_user';
  static const _isLoggedInKey = 'is_logged_in';
  static const _localeKey = 'app_locale';
  static const _localImagePathPrefix = 'local_image_path_';

  final SharedPreferences _preferences;

  bool get isLoggedIn => _preferences.getBool(_isLoggedInKey) ?? false;

  String? get savedLocale => _preferences.getString(_localeKey);

  AuthUser? getCachedUser() {
    final rawUser = _preferences.getString(_authUserKey);
    if (rawUser == null || rawUser.isEmpty) return null;
    try {
      final json = jsonDecode(rawUser) as Map<String, dynamic>;
      return AuthUser.fromJson(json);
    } catch (_) {
      // Corrupted cache — treat as unauthenticated; restoreSession will clear it.
      return null;
    }
  }

  Future<void> cacheUser(AuthUser user) async {
    await _preferences.setString(_authUserKey, jsonEncode(user.toJson()));
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
}
