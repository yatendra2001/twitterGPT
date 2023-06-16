import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String _isDataSaved = 'isDataSaved';

  Future<Map<String, dynamic>> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_isDataSaved) ??
        jsonEncode({
          {"isLoggedIn": false}
        });
    return jsonDecode(data);
  }

  Future<void> setData(String data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_isDataSaved, data);
  }
}
