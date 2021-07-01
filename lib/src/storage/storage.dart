/*
 * @Descripttion: 
 * @version: 1.0
 * @Author: Matthew
 * @Date: 2021-06-08 10:33:40
 * @LastEditTime: 2021-06-10 10:29:20
 */
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static SharedPreferences prefs;
  static Future<SharedPreferences> get _prefs async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
    return prefs;
  }

  /// 写入缓存
  /// 支持的类型 bool double int String List<String>
  /// 当写值为null则会删除
  static Future<bool> set(String key, dynamic value) async {
    var prefs = await _prefs;
    if (value == null) {
      return prefs.remove(key);
    } else if (value is bool) {
      return prefs.setBool(key, value);
    } else if (value is double) {
      return prefs.setDouble(key, value);
    } else if (value is int) {
      return prefs.setInt(key, value);
    } else if (value is String) {
      return prefs.setString(key, value);
    } else if (value is List<String>) {
      return prefs.setStringList(key, value);
    }
    throw ArgumentError(value);
  }

  static Future get(String key) async {
    var prefs = await _prefs;
    var res;
    if (key != null) {
      res = prefs.get(key);
    }
    return res;
  }

  static Future<bool> clear() async {
    var res = await (await _prefs).clear();
    return res;
  }

  static Future<Set<String>> getKeys() async {
    var res = (await _prefs).getKeys();
    return res;
  }

  static Future<bool> remove(String key) async {
    var res = await (await _prefs).remove(key);
    return res;
  }

  static Future<void> init() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
  }
}
