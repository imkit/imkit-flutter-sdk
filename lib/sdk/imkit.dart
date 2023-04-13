import 'dart:collection';

import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:imkit/generated/l10n.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/sdk/internal/imkit_action.dart';
import 'package:imkit/sdk/internal/imkit_internal.dart';
import 'package:imkit/sdk/internal/imkit_listener.dart';
import 'package:imkit/services/data/storage/im_local_storage.dart';
import 'package:imkit/services/db/im_database.dart';
import 'package:imkit/services/db/im_database_config.dart';
import 'package:imkit/widgets/messages/im_messages_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IMKit {
  static final IMKit _instance = IMKit._();
  static IMKit get instance => _instance;

  late IMKitInternal _internal;
  IMKitInternal get internal => _internal;

  late final IMKitAction _action;
  IMKitAction get action => _action;

  late final IMKitListener _listener;
  IMKitListener get listener => _listener;

  late final navigatorObservers = [IMRouteListenWidget.routeObserver, FlutterSmartDialog.observer];
  TransitionBuilder builder(TransitionBuilder? builder) => FlutterSmartDialog.init(builder: builder);

  late final IMKitStyle _style = IMKitStyle();

  Iterable<LocalizationsDelegate<dynamic>>? get localizationsDelegates => [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        IMKitS.delegate,
      ];

  List<Locale> get supportedLocales => IMKitS.delegate.supportedLocales;

  IMKit._();

  static String get uid => _instance._internal.state.uid;
  static String get bucket => _instance._internal.state.bucket;
  static IMKitStyle get style => _instance._style;
  static IMKitS get S => IMKitS.current;

  static Map<String, String> translatedMessage = HashMap();

  static init(IMStateBuilder builder) async {
    final database = await $FloorIMDatabase.databaseBuilder('imkit_flutter_database.db').addMigrations(IMDatabaseConfig.migrations()).build();

    debugPrint(">>> database path: ${await sqfliteDatabaseFactory.getDatabasePath('imkit_flutter_database.db')}");
    _instance._internal = IMKitInternal(
      builder: builder,
      prefs: await SharedPreferences.getInstance(),
      db: database,
    );

    _instance._action = IMKitAction(_instance._internal.data);
    _instance._listener = IMKitListener(database);

    _instance.socketConnect();

    _instance.internal.state.cloudTranslateActive = _instance.internal.data.localStorege.getValue(key: IMLocalStoregeKey.enableTranslate, defalut: false)!;
  }

  static Future<IMUser?> login({required String uid, String? token}) => _instance._internal
      .login(uid: uid, token: token)
      .then((user) => _instance._internal.data.subscribe(fcmToken: _instance._internal.state.fcmToken).then((_) => user));

  static void logout() => _instance._internal.logout();

  static void subscribe({required String fcmToken}) {
    _instance._internal.state.fcmToken = fcmToken;
    _instance._internal.data.subscribe(fcmToken: fcmToken);
  }

  static void toMessageView({required BuildContext context, required String roomId, IMRoom? room}) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => IMMessagesView(roomId: roomId, room: room)));
}

extension on IMKit {
  void socketConnect() {
    if (_internal.state.uid.isNotEmpty && _internal.state.token.isNotEmpty) {
      _internal.data.socketConnect();
    }
  }

  // void setUid(String uid) {
  //   if (_internal.state.uid != uid) {
  //     _internal.state.uid = uid;
  //     socketConnect();
  //   }
  // }

  // void setToken(String token) {
  //   if (_internal.state.token != token) {
  //     _internal.state.token = token;
  //     socketConnect();
  //   }
  // }

  // void socketDisConnect() {
  //   _internal.data.socketDisconnect();
  // }
}
