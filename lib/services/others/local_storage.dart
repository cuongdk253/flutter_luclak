import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SPreferentModule {
  final prefs = SharedPreferences.getInstance();

  Future<dynamic> getItem(String key) async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString(key) != null) {
      return jsonDecode(prefs.getString(key)!);
    } else {
      return null;
    }
  }

  void setItem(String key, dynamic data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(data));
  }

  void removeItem(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  void clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
