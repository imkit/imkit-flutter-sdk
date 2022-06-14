import 'package:collection/collection.dart';
import 'package:imkit/models/im_invitation.dart';
import 'package:imkit/models/im_message.dart';
import 'package:imkit/models/im_room.dart';
import 'package:imkit/models/im_state.dart';
import 'package:imkit/services/data/managers/im_message_data_manager.dart';
import 'package:imkit/services/data/managers/im_room_data_manager.dart';
import 'package:imkit/services/data/storage/im_local_storage.dart';
import 'package:imkit/services/network/socket/im_socket_client.dart';
import 'package:imkit/services/network/socket/im_socket_client_event.dart';

class IMData {
  final IMState state;
  late final IMRoomDataManager _roomDataManager = IMRoomDataManager();
  late final IMMessageDataManager _messageDataManager = IMMessageDataManager();
  late final IMLocalStorage localStorege;
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

  IMData({required this.state, required this.localStorege});

  /// Room
  void syncRooms({bool isRefresh = false}) async {
    final lastUpdatedAt = isRefresh ? null : localStorege.getValue(key: IMLocalStoregeKey.lastRoomUpdatedAt);
    const limit = 15;
    int skip = 0;
    bool isCountinue = true;
    List<IMRoom> tmpRooms = [];
    do {
      final rooms = await _roomDataManager.fetchRooms(skip: skip, limit: limit, lastUpdatedAt: lastUpdatedAt);
      tmpRooms.addAll(rooms);
      _roomDataManager.insertItems(rooms);
      skip += limit;
      isCountinue = rooms.length >= limit;
    } while (isCountinue);

    final lastRoomUpdatedAt = tmpRooms.fold<int>(
      0,
      (previousValue, element) =>
          (element.updatedAt?.millisecondsSinceEpoch ?? 0) > previousValue ? (element.updatedAt?.millisecondsSinceEpoch ?? 0) : previousValue,
    );
    if (lastRoomUpdatedAt > 0) {
      localStorege.setValue(key: IMLocalStoregeKey.lastRoomUpdatedAt, value: lastRoomUpdatedAt + 1000);
    }
  }

  /// Message
  void syncMessages({required String roomId, int limit = 20}) async {
    final latestMessage = await _messageDataManager.fetchLatestMessage(roomId: roomId);
    String? latestMessageId = latestMessage?.id;
    bool isCountinue = true;

    do {
      final messages = await _messageDataManager.fetchMessages(roomId: roomId, beforeMessageId: latestMessageId, limit: limit);
      _messageDataManager.insertItems(messages);
      isCountinue = messages.length >= limit;
      latestMessageId = messages.lastOrNull?.id;
    } while (isCountinue);
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
