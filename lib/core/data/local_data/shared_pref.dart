import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management_system/core/utils/extensions/bool_extensions.dart';
import 'package:task_management_system/core/utils/extensions/double_extensions.dart';
import 'package:task_management_system/core/utils/extensions/int_extensions.dart';
import 'package:task_management_system/core/utils/extensions/string_extensions.dart';

import '../../app_store/app_store.dart';

Future<SharedPreferences> getSharedPref() async {
  return await SharedPreferences.getInstance();
}

Future<bool> setValue(String key, dynamic value, {bool print = true}) async {
  if (value == null) {
    if (print) log('$key - value is null');
    return Future.value(false);
  }
  if (print) log('${value.runtimeType} - $key - $value');

  if (value is String) {
    return await sharedPreferences.setString(key, value.validate());
  } else if (value is int) {
    return await sharedPreferences.setInt(key, value.validate());
  } else if (value is bool) {
    return await sharedPreferences.setBool(key, value.validate());
  } else if (value is double) {
    return await sharedPreferences.setDouble(key, value.validate());
  } else if (value is Map<String, dynamic>) {
    return await sharedPreferences.setString(key, jsonEncode(value));
  } else if (value is List<String>) {
    return await sharedPreferences.setStringList(key, value);
  } else {
    throw ArgumentError(
        'Invalid value ${value.runtimeType} - Must be a String, int, bool, double, Map<String, dynamic> or StringList');
  }
}

bool ifKeyEx(String key) {
  bool isDone = false;
  sharedPreferences.getKeys().forEach((element) {
    if (element == key) {
      isDone = true;
    }
  });
  return isDone;
}

List<String>? getStringListAsync(String key) {
  return sharedPreferences.getStringList(key);
}

bool getBoolAsync(String key, {bool defaultValue = false}) {
  return sharedPreferences.getBool(key) ?? defaultValue;
}

double getDoubleAsync(String key, {double defaultValue = 0.0}) {
  return sharedPreferences.getDouble(key) ?? defaultValue;
}

int getIntAsync(String key, {int defaultValue = 0}) {
  return sharedPreferences.getInt(key) ?? defaultValue;
}

String getStringAsync(String key, {String defaultValue = ''}) {
  return sharedPreferences.getString(key) ?? defaultValue;
}

Map<String, dynamic> getJSONAsync(String key,
    {Map<String, dynamic>? defaultValue}) {
  if (sharedPreferences.containsKey(key) &&
      sharedPreferences.getString(key).validate().isNotEmpty) {
    return jsonDecode(sharedPreferences.getString(key)!);
  } else {
    return defaultValue ?? {};
  }
}

Future<bool> removeKey(String key) async {
  return await sharedPreferences.remove(key);
}

Future<bool> clearSharedPref() async {
  return await sharedPreferences.clear();
}

