import 'dart:ffi';

import 'package:facebook/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  static Future<void> storeTokens(
      String accessToken, String refreshToken) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString(Constants.accessToken, accessToken);
    pref.setString(Constants.refreshToken, refreshToken);
  }

  static Future<Map<String, String?>> getTokens() async {
    final pref = await SharedPreferences.getInstance();
    final String? accessToken = pref.getString(Constants.accessToken);
    final String? refreshToken = pref.getString(Constants.refreshToken);

    Map<String, String?> map = {
      Constants.accessToken: accessToken,
      Constants.refreshToken: refreshToken
    };

    return map;
  }

  static Future<void> clearTokens() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove(Constants.accessToken);
    pref.remove(Constants.refreshToken);
    await pref.clear();
  }

  static Future<bool> isTokenExits(String name) async {
    final map = await getTokens();

    if (map[name] == null) return false;

    return true;
  }
}
