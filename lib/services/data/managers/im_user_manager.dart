import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/services/data/managers/im_base_data_manager.dart';

class IMUserDataManager extends IMBaseDataManager {
  late final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  Future<void> insertItem(IMUser user) {
    return database.userDao.insertItem(user);
  }

  Future<void> insertItems(List<IMUser> users) {
    return database.userDao.insertItems(users);
  }

  Future<IMUser> getMe() async {
    IMUser? me = await _findMe();
    if (me == null) {
      me = await _fetchMe();
      insertItem(me);
    }
    return me;
  }

  Future<IMUser> updateMe({String? nickname, String? avatarUrl, String? description}) async {
    final oldMe = await getMe();
    final newMe = await api.user.updateMe(
      nickname: nickname ?? oldMe.nickname,
      avatarUrl: avatarUrl ?? oldMe.avatarUrl,
      description: description ?? oldMe.desc,
    );
    insertItem(newMe);

    return newMe;
  }

  void syncMe() async {
    insertItem(await _fetchMe());
  }

  Future<IMUser?> _findMe() {
    return database.userDao.findUser(IMKit.uid);
  }

  Future<IMUser> _fetchMe() {
    return api.user.fetchMe();
  }

  Future<bool> subscribe({required String fcmToken}) {
    return getDeviceId()
        .then((deviceId) {
          if ((deviceId ?? "").isNotEmpty) {
            return api.user.subscribe(
              fcmToken: fcmToken,
              type: "fcm",
              deviceId: deviceId ?? "",
            );
          }
          throw Error();
        })
        .then((_) => true)
        .catchError((_) => false);
  }

  Future<bool> unsubscribe() {
    return getDeviceId()
        .then((deviceId) {
          if ((deviceId ?? "").isNotEmpty) {
            return api.user.unsubscribe(
              type: "fcm",
              deviceId: deviceId ?? "",
            );
          }
          throw Error();
        })
        .then((_) => true)
        .catchError((_) => false);
  }
}

extension on IMUserDataManager {
  Future<String?> getDeviceId() {
    if (Platform.isIOS) {
      return deviceInfoPlugin.iosInfo.then((value) => value.identifierForVendor).catchError((_) => null);
    } else if (Platform.isAndroid) {
      return deviceInfoPlugin.androidInfo.then((value) => value.androidId).catchError((_) => null);
    }
    return Future.value(null);
  }
}
