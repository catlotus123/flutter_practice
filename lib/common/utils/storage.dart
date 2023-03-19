import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  StorageUtil._internal();
  factory StorageUtil() => _instance;

  static final StorageUtil _instance = StorageUtil._internal();

  late SharedPreferences _preferences;

  Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<bool> setJson(String key, dynamic jsonVal) async {
    String jsonString = jsonEncode(jsonVal);
    return await _preferences.setString(key, jsonString);
  }

  dynamic getJson(String key) {
    String? jsonString = _preferences.getString(key);
    return jsonString == null ? null : jsonDecode(jsonString);
  }

  Future<bool> setBool(String key, bool val) async {
    return await _preferences.setBool(key, val);
  }

  bool getBool(String key) {
    bool? val = _preferences.getBool(key);
    return val ?? false;
  }

  Future<bool> remove(String key) async {
    return await _preferences.remove(key);
  }
}
