import 'package:flutter/material.dart';
import 'package:imkit/generated/l10n.dart';
import 'package:imkit/models/im_state.dart';
import 'package:imkit/models/im_user.dart';
import 'package:imkit/services/data/im_data.dart';
import 'package:imkit/services/data/storage/im_local_storage.dart';
import 'package:imkit/services/db/im_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IMKitInternal {
  late final IMState _state;
  IMState get state => _state;

  late final IMLocalStorage _localStorage;
  IMLocalStorage get localStorage => _localStorage;

  late final IMDatabase _database;
  IMDatabase get database => _database;

  late final IMData _data = IMData(state: state, localStorege: localStorage);
  IMData get data => _data;

  late final IMKitS localization = IMKitS.current;

  IMKitInternal({required IMStateBuilder builder, required SharedPreferences prefs, required IMDatabase db}) {
    _state = builder.build();
    _localStorage = IMLocalStorage(prefs);
    _database = db;
  }

  Future<IMUser?> login({required String uid, String? token}) {
    if (uid.isEmpty) {
      return Future.value(null);
    }
    return Future.value(token ?? "")
        .then((value) => (value.isNotEmpty) ? Future.value(value) : _data.getToken(userId: uid).then((value) => value.token))
        .then((token) {
      state.uid = uid;
      state.token = token;
      _data.socketConnect();
      return _data.getMe();
    }).catchError((error) {
      debugPrint(">>> IMKit.connect error: ${error.toString()}");
    });
  }

  void logout() {
    _state.logout();
    _localStorage.clean();
    _database.clean();
    _data.socketDisconnect();
  }
}
