import 'package:enume/enume.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'im_local_storage.g.dart';

@Enume(nameMethod: false)
enum IMLocalStoregeKey {
  @Value("lastRoomUpdatedAt")
  lastRoomUpdatedAt,
}

class IMLocalStorage {
  late final SharedPreferences _prefs;

  IMLocalStorage(SharedPreferences prefs) {
    _prefs = prefs;
  }

  void clean() {
    remove(key: IMLocalStoregeKey.lastRoomUpdatedAt);
  }

  Future<bool> setValue({required IMLocalStoregeKey key, required dynamic value}) async {
    if (value is int) {
      return await _prefs.setInt(key.value, value);
    } else if (value is bool) {
      return await _prefs.setBool(key.value, value);
    } else if (value is double) {
      return await _prefs.setDouble(key.value, value);
    } else if (value is String) {
      return await _prefs.setString(key.value, value);
    } else if (value is List<String>) {
      return await _prefs.setStringList(key.value, value);
    } else {
      return Future.value(false);
    }
  }

  T? getValue<T>({required IMLocalStoregeKey key, T? defalut}) {
    dynamic value;
    switch (key) {
      case IMLocalStoregeKey.lastRoomUpdatedAt:
        value = _prefs.getInt(key.value) ?? defalut;
        break;
    }
    if (value != null) {
      return value as T;
    }
    return defalut;
  }

  Future<bool> remove({required IMLocalStoregeKey key}) => _prefs.remove(key.value);
}
