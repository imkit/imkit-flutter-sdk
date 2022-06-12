import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:imkit/extensions/list_ext.dart';
import 'package:imkit/models/im_image.dart';
import 'package:imkit/models/im_invitation.dart';
import 'package:imkit/models/im_message.dart';
import 'package:imkit/models/im_response_object.dart';
import 'package:imkit/models/im_room.dart';
import 'package:imkit/models/im_state.dart';
import 'package:imkit/models/im_user.dart';
import 'package:imkit/sdk/internal/imkit_action.dart';
import 'package:imkit/services/data/managers/im_file_data_manager.dart';
import 'package:imkit/services/data/managers/im_message_data_manager.dart';
import 'package:imkit/services/data/managers/im_room_data_manager.dart';
import 'package:imkit/services/data/managers/im_user_manager.dart';
import 'package:imkit/services/data/storage/im_local_storage.dart';
import 'package:imkit/services/network/socket/im_socket_client.dart';
import 'package:imkit/services/network/socket/im_socket_client_event.dart';
import 'package:photo_manager/photo_manager.dart';

class IMData {
  final IMState state;
  late final IMRoomDataManager _roomDataManager = IMRoomDataManager();
  late final IMMessageDataManager _messageDataManager = IMMessageDataManager();
  late final IMUserDataManager _userDataManager = IMUserDataManager();
  late final IMFileDataManager _fileDataManager = IMFileDataManager();
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

  /// User
  Future<IMUser> getMe() => _userDataManager.getMe();

  /// Room
  void syncRooms({bool isRefresh = false}) async {
    final lastUpdatedAt = isRefresh ? null : localStorege.getValue(key: IMLocalStoregeKey.lastRoomUpdatedAt);
    const limit = 15;
    int skip = 0;
    bool isCountinue = true;
    List<IMRoom> tmpRooms = [];
    List<IMUser> users = [];
    do {
      final rooms = await _roomDataManager.fetchRooms(skip: skip, limit: limit, lastUpdatedAt: lastUpdatedAt);
      tmpRooms.addAll(rooms);
      users.addAll(rooms.expand((e) => e.members));
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
    if (users.isNotEmpty) {
      _userDataManager.insertItems(users.unique((e) => e.id));
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

  void sendTextMessage({required String roomId, required String text, IMResponseObject? responseObject}) async {
    final IMMessage localMessage = IMMessage.fromText(
      roomId: roomId,
      sender: await getMe(),
      responseObject: responseObject,
      text: text,
    );
    final newMessage = await _messageDataManager.preSendMessage(localMessage: localMessage);
    _messageDataManager.sendNewMessage(localMessage: newMessage);
  }

  void preSendImageMessage({required String roomId, required List<AssetEntity> assetEntities}) async {
    List<IMImage?> images = await Future.wait(assetEntities.map((element) async {
      final list = await element.thumbnailDataWithSize(const ThumbnailSize.square(1500), quality: 90);
      final originalFile = await element.file;
      final originalFileSize = await originalFile?.length();
      File? thumbnailFile = originalFile;
      if ((originalFileSize ?? 0) > 1000000) {
        final originalFilename = originalFile?.path.split('/').last ?? "";
        final originalDirectory = (originalFile?.path ?? "").replaceAll("/$originalFilename", '');
        final thumbnailFilepath = "$originalDirectory/thumbnail_$originalFilename";
        thumbnailFile = list != null ? await File(thumbnailFilepath).writeAsBytes(list) : originalFile;
      }

      if (originalFile != null) {
        return IMImage(
          originalUrl: "",
          thumbnailUrl: "",
          width: element.width,
          height: element.height,
          originalPath: originalFile.path,
          thumbnailPath: thumbnailFile?.path ?? originalFile.path,
        );
      }
      return null;
    }));
    final IMMessage localMessage = IMMessage.fromImages(
      roomId: roomId,
      sender: await getMe(),
      images: images.whereNotNull().toList(),
    );
    _messageDataManager.preSendMessage(localMessage: localMessage);
  }

  void sendImageMessage({required IMMessage message, UploadProgress? uploadProgress, CancelToken? cancelToken}) async {
    try {
      message.images = await Future.wait(
        message.images.map(
          (element) => _fileDataManager.uploadImage(image: element, uploadProgress: uploadProgress, cancelToken: cancelToken),
        ),
      );
      _messageDataManager.sendNewMessage(localMessage: message);
    } catch (_) {
      uploadProgress?.call(0);
      message.status = IMMessageStatus.undelivered;
      _messageDataManager.updateItem(message);
    }
  }

  void resendMessage({required IMMessage message}) {
    _messageDataManager.resendMessage(localMessage: message);
  }

  void deleteMessage({required IMMessage message}) {
    _messageDataManager.deleteItem(message);
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
