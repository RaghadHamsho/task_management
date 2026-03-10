import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  bool containsKey(String key);

  List<String> getList(String key);

  Future<void> cacheList(String key, List<String> value);

  Future<bool> removeValue(String key);

  List<String> toListForCash<T>(List<T> model) {
    List<String> cashList = [];
    for (T element in model) {
      final item = jsonEncode(element);
      cashList.add(item);
    }
    return cashList;
  }

  String toValueForCash<T>(T model) {
    return jsonEncode(model);
  }

  List<T> convertToListOfObjectFromLocal<T>(List<String> list, T Function(Map<String, dynamic>) fromJson) {
    List<T> objectList = [];
    Map<String, dynamic> objectMap = {};
    for (String item in list) {
      objectMap = jsonDecode(item) as Map<String, dynamic>;
      final T object = fromJson(objectMap);
      objectList.add(object);
    }
    return objectList;
  }
}

class LocalDataSourceSharedPreferences extends LocalDataSource {
  SharedPreferences sharedPreferences;

  LocalDataSourceSharedPreferences(this.sharedPreferences);

  @override
  Future<void> cacheList(String key, List<String> value) async {
    bool done = await sharedPreferences.setStringList(key, value);
    if (!done) {
      throw "Error while writing to local storage";
    }
    return;
  }

  @override
  List<String> getList(String key) {
    List<String>? result = sharedPreferences.getStringList(key);
    if (result == null) {
      throw "Error while reading from local storage";
    } else {
      return result;
    }
  }

  @override
  Future<bool> removeValue(String key) async {
    final result = await sharedPreferences.remove(key);
    if (result) {
      return true;
    } else {
      return false;
    }
  }

  @override
  bool containsKey(String key) {
    return sharedPreferences.containsKey(key);
  }
}

