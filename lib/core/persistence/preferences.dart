import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static const token = 'token';
  static Future<SharedPreferences>? prefs = SharedPreferences.getInstance();
  static SharedPreferences? prefsInstance;

  static Future<void> init() async {
    prefsInstance = await prefs;
  }

  static void dispose() {
    prefs = null;
    prefsInstance = null;
    log(prefsInstance.toString());
  }

  static Future<int> getInt(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? value;
  }

  static setInt(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  static setString(String key, String? value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value!);
  }

  static Future<String> getString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }

  static setBool(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static Future<bool> getBool(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? value;
  }

  static setDouble(String key, double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, value);
  }

  static Future<double> getDouble(String key, double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key) ?? value;
  }

  static clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
