import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:imkit/models/im_invitation.dart';
import 'package:imkit/models/im_message.dart';
import 'package:imkit/models/im_room.dart';
import 'package:imkit/models/im_state.dart';
import 'package:imkit/sdk/internal/imkit_streams.dart';
import 'package:imkit/services/network/im_socket_client.dart';
import 'package:imkit/services/network/im_socket_client_event.dart';

class IMKitInternal with WidgetsBindingObserver {
  late final IMKitStreamManager _streamManager = IMKitStreamManager();
  IMKitStreamManager get streamManager => _streamManager;

  late final IMSocketClient _socketClient = IMSocketClient(IMSocketClientEvent()
    ..onDidReceiveRoom = onSocketDidReceiveRoom
    ..onDidReceiveMessage = onSocketDidReceiveMessage
    ..onDidReceiveLastReadMessage = onSocketDidReceiveLastReadMessage
    ..onDidReceiveTyping = onSocketDidReceiveTyping
    ..onDidReceiveInvitation = onSocketDidReceiveInvitation
    ..onDidReceiveCancelInvitation = onSocketDidReceiveCancelInvitation
    ..onDidReceiveMyPrefChange = onSocketDidReceiveMyPrefChange
    ..onDidReceiveRoomPref = onSocketDidReceiveRoomPref);
  IMSocketClient get socketClient => _socketClient;

  late final IMState _state;
  IMState get state => _state;

  IMKitInternal(IMStateBuilder builder) {
    _state = builder.build();
  }

  connect() {
    _socketClient.connect();
  }

  reconnect() {
    _socketClient.reconnect();
  }

  disconnect() {
    _socketClient.disconnect();
  }

  logout() {
    _streamManager.reset();
    _state.logout();
    _socketClient.disconnect();
  }
}

// Socket
extension on IMKitInternal {
  void onSocketDidReceiveRoom(IMRoom room) {}
  void onSocketDidReceiveMessage(IMMessage message) {}
  void onSocketDidReceiveLastReadMessage(String roomId, String uid, String messageId) {}
  void onSocketDidReceiveTyping(String roomId, String uid) {}
  void onSocketDidReceiveInvitation(IMInvitation invitation) {}
  void onSocketDidReceiveCancelInvitation(String invitationId) {}
  void onSocketDidReceiveMyPrefChange(Map<String, dynamic> json) {}
  void onSocketDidReceiveRoomPref(Map<String, dynamic> json) {}
}
