import 'dart:async';

import 'package:imkit/models/im_invitation.dart';
import 'package:imkit/models/im_message.dart';
import 'package:imkit/models/im_room.dart';
import 'package:imkit/models/im_state.dart';
import 'package:imkit/sdk/internal/imkit_streams.dart';
import 'package:imkit/services/data/managers/im_room_data_manager.dart';
import 'package:imkit/services/network/socket/im_socket_client.dart';
import 'package:imkit/services/network/socket/im_socket_client_event.dart';

class IMData {
  final IMState state;
  final IMKitStreamManager stream;
  late final IMRoomDataManager _roomDataManager = IMRoomDataManager();

  late final IMSocketClient _socketClient = IMSocketClient(
      state: state,
      event: IMSocketClientEvent()
        ..onDidReceiveRoom = onSocketDidReceiveRoom
        ..onDidReceiveMessage = onSocketDidReceiveMessage
        ..onDidReceiveLastReadMessage = onSocketDidReceiveLastReadMessage
        ..onDidReceiveTyping = onSocketDidReceiveTyping
        ..onDidReceiveInvitation = onSocketDidReceiveInvitation
        ..onDidReceiveCancelInvitation = onSocketDidReceiveCancelInvitation
        ..onDidReceiveMyPrefChange = onSocketDidReceiveMyPrefChange
        ..onDidReceiveRoomPref = onSocketDidReceiveRoomPref);
  IMSocketClient get socketClient => _socketClient;

  IMData({required this.state, required this.stream});

  /// Room
  void syncRooms() {
    //TODO: save data to local db
    _roomDataManager.fetchRooms().then((value) => stream.rooms.add(value));
  }

  /// Stream
  Stream<T> observer<T>(StreamController<T> streamController) async* {
    await for (final res in streamController.stream) {
      yield res;
    }
  }

  /// Socket
  socketConnect() {
    _socketClient.connect();
  }

  socketReconnect() {
    _socketClient.reconnect();
  }

  socketDisconnect() {
    _socketClient.disconnect();
  }
}

// Socket
extension on IMData {
  void onSocketDidReceiveRoom(IMRoom room) {}
  void onSocketDidReceiveMessage(IMMessage message) {}
  void onSocketDidReceiveLastReadMessage(String roomId, String uid, String messageId) {}
  void onSocketDidReceiveTyping(String roomId, String uid) {}
  void onSocketDidReceiveInvitation(IMInvitation invitation) {}
  void onSocketDidReceiveCancelInvitation(String invitationId) {}
  void onSocketDidReceiveMyPrefChange(Map<String, dynamic> json) {}
  void onSocketDidReceiveRoomPref(Map<String, dynamic> json) {}
}
