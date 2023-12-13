import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static String userData = "USER";
  static String userLocation = "userLocation";
  static String isLongedIn = "isLongedIn";
  static String isProfileUpdate = "isProfileUpdate";
  static String isOnBoarding = "isOnBoarding";

  /// Saving String to Shared Preferences
  static void saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  /// Saving Bool to Shared Preferences
  static void saveBoolData(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  /// Saving String to Shared Preferences
  static void saveStringData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString(key, value);
  }

  /// Saving Int to Shared Preferences
  static void saveIntData(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  /// Saving Double to Shared Preferences
  static void saveDoubleData(String key, double value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, value);
  }

  /// ===============reading data============

  // Reading String to Shared Preferences
  static Future<String> getStringData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }

  /// Reading Int to Shared Preferences
  static Future<int> getIntData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 0;
  }

  /// Reading Double to Shared Preferences
  static Future<double> getDoubleData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key) ?? 0.0;
  }

  /// Reading Bool to Shared Preferences
  static Future<bool> getBoolData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  /// removing data from Shared Preferences
  static void removeData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  /// removing data from Shared Preferences
  static Future<bool> checkValueExistence(
      SharedPreferences prefs, String key) async {
    return prefs.containsKey(key);
  }
}
