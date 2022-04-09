import 'package:enume/enume.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'im_local_storage.g.dart';

@Enume(nameMethod: false)
enum IMLocalStoregeKey {
  @Value("lastRoomUpdatedAt")
  lastRoomUpdatedAt,
}

class IMLocalStorage {
  static final IMLocalStorage instance = IMLocalStorage._();

  late final SharedPreferences _prefs;

  IMLocalStorage._() {
    _initialize();
  }

  void _initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void clean() {
    remove(key: IMLocalStoregeKey.lastRoomUpdatedAt);
  }

  Future<bool> setValue({required IMLocalStoregeKey key, required dynamic value}) {
    if (value is int) {
      return _prefs.setInt(key.value, value);
    } else if (value is bool) {
      return _prefs.setBool(key.value, value);
    } else if (value is double) {
      return _prefs.setDouble(key.value, value);
    } else if (value is String) {
      return _prefs.setString(key.value, value);
    } else if (value is List<String>) {
      return _prefs.setStringList(key.value, value);
    } else {
      return Future.value(false);
    }
  }

  T? getValue<T>({required IMLocalStoregeKey key, T? defalut}) {
    if (T is int) {
      return (_prefs.getInt(key.value) as T) ?? defalut;
    } else if (T is bool) {
      return (_prefs.getBool(key.value) as T) ?? defalut;
    } else if (T is double) {
      return (_prefs.getDouble(key.value) as T) ?? defalut;
    } else if (T is String) {
      return (_prefs.getString(key.value) as T) ?? defalut;
    } else if (TextAlignVertical.top is List<String>) {
      return (_prefs.getStringList(key.value) as T) ?? defalut;
    } else {
      return null;
    }
  }

  Future<bool> remove({required IMLocalStoregeKey key}) => _prefs.remove(key.value);
}
