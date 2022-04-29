import 'dart:developer';

import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/models/im_state.dart';
import 'package:imkit/sdk/internal/imkit_internal.dart';

class IMKit {
  static final IMKit instance = IMKit._();

  late IMKitInternal _internal;

  static initialize(IMStateBuilder builder) {
    instance._internal = IMKitInternal(builder);
  }

  IMKit._();

  IMKitInternal getInternal() => _internal;

  connect() {
    _internal.data.socketConnect();
  }

  disconnect() {
    _internal.data.socketDisconnect();
  }

  setUid(String uid) {
    if (_internal.state.uid != uid) {
      _internal.state.uid = uid;
      if (_internal.state.uid.isNotEmpty && _internal.state.token.isNotEmpty) {
        _internal.data.socketReconnect();
      }
    }
  }

  setToken(String token) {
    if (_internal.state.token != token) {
      _internal.state.token = token;
      if (_internal.state.uid.isNotEmpty && _internal.state.token.isNotEmpty) {
        _internal.data.socketReconnect();
      }
    }
  }

  fetchRooms() {
    _internal.data.syncRooms();
  }

  Stream<List<IMRoom>> roomsStream() {
    return _internal.data.observer(_internal.streamManager.rooms);
  }
}
