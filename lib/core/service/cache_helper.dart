import 'dart:convert';

import 'package:fit_flow/features/auth/data/model/auth_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  CacheHelper(this._preferences);

  static const _authUserKey = 'auth_user';
  static const _isLoggedInKey = 'is_logged_in';

  final SharedPreferences _preferences;

  bool get isLoggedIn => _preferences.getBool(_isLoggedInKey) ?? false;

  AuthUser? getCachedUser() {
    final rawUser = _preferences.getString(_authUserKey);
    if (rawUser == null || rawUser.isEmpty) return null;

    final json = jsonDecode(rawUser) as Map<String, dynamic>;
    return AuthUser.fromJson(json);
  }

  Future<void> cacheUser(AuthUser user) async {
    await _preferences.setString(_authUserKey, jsonEncode(user.toJson()));
    await _preferences.setBool(_isLoggedInKey, true);
  }

  Future<void> clearAuthData() async {
    await _preferences.remove(_authUserKey);
    await _preferences.setBool(_isLoggedInKey, false);
  }
}
