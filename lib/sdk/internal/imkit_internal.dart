import 'package:flutter/widgets.dart';
import 'package:imkit/models/im_state.dart';
import 'package:imkit/sdk/internal/imkit_streams.dart';
import 'package:imkit/services/data/im_data.dart';
import 'package:imkit/services/data/storage/im_local_storage.dart';

class IMKitInternal with WidgetsBindingObserver {
  late final IMKitStreamManager _streamManager = IMKitStreamManager();
  IMKitStreamManager get streamManager => _streamManager;

  late final IMState _state;
  IMState get state => _state;

  late final IMLocalStorage _localStorage = IMLocalStorage.instance;
  IMLocalStorage get localStorage => _localStorage;

  late final IMData _data = IMData(state: state, stream: streamManager);
  IMData get data => _data;

  IMKitInternal(IMStateBuilder builder) {
    _state = builder.build();
  }

  logout() {
    _streamManager.reset();
    _state.logout();
    _localStorage.clean();
    _data.socketDisconnect();
  }
}
