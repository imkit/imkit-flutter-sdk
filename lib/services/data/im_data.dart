import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:imkit/extensions/list_ext.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/models/im_image.dart';
import 'package:imkit/models/im_member_property.dart';
import 'package:imkit/models/im_response_object.dart';
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
    final localRooms = await _roomDataManager.findRooms();
    const limit = 15;
    int skip = 0;
    bool isCountinue = true;
    List<IMRoom> tmpRooms = [];
    List<IMUser> users = [];
    do {
      final rooms = await _roomDataManager.fetchRooms(skip: skip, limit: limit, lastUpdatedAt: lastUpdatedAt);
      for (var room in rooms) {
        room.memberProperties = localRooms.firstWhereOrNull((element) => element.id == room.id)?.memberProperties ?? [];
      }
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

  Future<void> _setRead({required String roomId}) async {
    final lastReadMessageId = (await _messageDataManager.findLatestMessage(roomId: roomId))?.id;
    if ((lastReadMessageId ?? "").isNotEmpty) {
      final memberProperty = await _roomDataManager.setRead(roomId: roomId, lastReadMessageId: lastReadMessageId ?? "");
      final room = await _roomDataManager.findRoom(roomId: roomId);

      if (room != null) {
        room.setMemberProperty(memberProperty);
        room.numberOfUnreadMessages = memberProperty.badge;
        _roomDataManager.updateItem(room);
      }
    }
    return;
  }

  Future<void> setReadIfNeed({required String roomId, required IMMessage message}) async {
    if (message.isMe || message.status != IMMessageStatus.delivered) {
      return;
    }
    final room = await _roomDataManager.findRoom(roomId: roomId);
    if (room != null) {
      final lastReadMessageId = room.memberProperties.firstWhereOrNull((element) => element.uid == IMKit.uid)?.lastReadMessageId;
      if ((lastReadMessageId ?? "").isNotEmpty && message.createdAt != null) {
        final lastReadMessageCreatedAt = (await _messageDataManager.findMessage(id: lastReadMessageId!))?.createdAt;
        if (lastReadMessageCreatedAt != null && (message.createdAt?.isAfter(lastReadMessageCreatedAt) ?? false)) {
          final memberProperty = await _roomDataManager.setRead(roomId: roomId, lastReadMessageId: message.id);
          room.setMemberProperty(memberProperty);
          room.numberOfUnreadMessages = memberProperty.badge;
          _roomDataManager.updateItem(room);
        }
      }
    }
  }

  // void _updateRoomLastMessage({required IMMessage? message}) async {
  //   if (message != null) {
  //     final room = await _roomDataManager.fetchRoom(roomId: message.roomId);
  //     _roomDataManager.insertItem(room);
  //   }
  // }

  /// Message
  void initEntryRoom({required String roomId}) async {
    final room = await _roomDataManager.fetchRoom(roomId: roomId);
    await _roomDataManager.insertItem(room);
    await _syncMessages(roomId: roomId);
    await _setRead(roomId: roomId);
    _syncMembersWhoHaveRead(roomId: roomId);
  }

  Future<IMMessage> sendTextMessage({required String roomId, required String text, IMResponseObject? responseObject}) async {
    final IMMessage localMessage = IMMessage.fromText(
      roomId: roomId,
      sender: await getMe(),
      responseObject: responseObject,
      text: text,
    );
    final newMessage = await _messageDataManager.preSendMessage(localMessage: localMessage);
    return _messageDataManager.sendNewMessage(localMessage: newMessage);
  }

  Future<List<IMMessage>> preSendImageMessages({required String roomId, required List<AssetEntity> assetEntities}) async {
    final me = await getMe();
    final messages = await Future.wait(assetEntities.map((element) async {
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
        final image = IMImage(
          originalUrl: "",
          thumbnailUrl: "",
          width: element.width,
          height: element.height,
          originalPath: originalFile.path,
          thumbnailPath: thumbnailFile?.path ?? originalFile.path,
        );
        final message = IMMessage.fromImages(
          roomId: roomId,
          sender: me,
          images: [image],
        );
        return _messageDataManager.preSendMessage(localMessage: message);
      }
      return null;
    }));

    return messages.whereNotNull().toList();
  }

  Future<IMMessage> sendImageMessage({required IMMessage message, UploadProgress? uploadProgress, CancelToken? cancelToken}) async {
    try {
      message.images = await Future.wait(
        message.images.map(
          (element) => _fileDataManager.uploadImage(image: element, uploadProgress: uploadProgress, cancelToken: cancelToken),
        ),
      );
      return _messageDataManager.sendNewMessage(localMessage: message);
    } catch (_) {
      uploadProgress?.call(0);
      message.status = IMMessageStatus.undelivered;
      _messageDataManager.updateItem(message);
      return message;
    }
  }

  Future<IMMessage> resendMessage({required IMMessage message}) async {
    return _messageDataManager.resendMessage(localMessage: message);
  }

  void deleteMessage({required IMMessage message}) {
    _messageDataManager.deleteItem(message);
  }

  Future<void> _syncMessages({required String roomId, int limit = 20}) async {
    final localMessages = await _messageDataManager.findMessages(roomId: roomId);
    final localMessageIds = localMessages.map((e) => e.id);
    String? latestMessageId;
    bool isCountinue = true;

    do {
      final messages = await _messageDataManager.fetchMessages(roomId: roomId, beforeMessageId: latestMessageId, limit: limit);
      for (var message in messages) {
        isCountinue &= !localMessageIds.contains(message.id);
        message.membersWhoHaveRead = localMessages.firstWhereOrNull((element) => element.id == message.id)?.membersWhoHaveRead ?? [];
      }
      _messageDataManager.insertItems(messages);
      isCountinue &= messages.length >= limit;
      latestMessageId = messages.lastOrNull?.id;
    } while (isCountinue);

    return;
  }

  void _syncMembersWhoHaveRead({required String roomId}) async {
    final IMRoom? room = await _roomDataManager.findRoom(roomId: roomId);
    if (room == null) {
      return;
    }

    final List<IMMemberProperty> memberProperties = room.memberProperties;
    final List<String> lastReadMessageIds = memberProperties.map((element) => element.lastReadMessageId).where((element) => element.isNotEmpty).toList();
    final List<IMMessage> messages = lastReadMessageIds.isNotEmpty ? await _messageDataManager.findMessagesByIds(ids: lastReadMessageIds) : [];
    final List<IMMessage> messagesSentByMe =
        (await _messageDataManager.findMessages(roomId: roomId)).where((element) => element.sender?.id == IMKit.uid).toList();
    final List<IMMessage> ascendingMessageSentByMe = messagesSentByMe;
    final List<IMMessage> descendingMessageSentByMe = messagesSentByMe.reversed.toList();
    final List<IMMessage> updatedMessages = [];
    for (var memberProperty in memberProperties) {
      final lastReadMessageCreateTime = messages.firstWhereOrNull((element) => element.id == memberProperty.lastReadMessageId)?.createdAt;
      if (lastReadMessageCreateTime != null) {
        for (var message in descendingMessageSentByMe) {
          final createdAt = message.createdAt;

          if (createdAt != null && createdAt.compareTo(lastReadMessageCreateTime) <= 0 && !message.membersWhoHaveRead.contains(memberProperty.uid)) {
            if (message.read(memberProperty.uid)) {
              updatedMessages.add(message);
            }
          }
        }
      }
    }
    final membersInRoom = memberProperties.map((e) => e.uid);
    final hasSomeoneLeaveRoom = ascendingMessageSentByMe.firstOrNull?.membersWhoHaveRead
            .fold<bool>(false, (previousValue, element) => previousValue || !membersInRoom.contains(element)) ??
        false;
    if (hasSomeoneLeaveRoom) {
      final uidsLeaveRoom = ascendingMessageSentByMe.firstOrNull?.membersWhoHaveRead.where((e) => !membersInRoom.contains(e)) ?? [];
      for (var message in ascendingMessageSentByMe) {
        for (var uid in uidsLeaveRoom) {
          if (message.removeMemberWhoReadThis(uid)) {
            updatedMessages.add(message);
          }
        }
      }
    }
    if (updatedMessages.isNotEmpty) {
      _messageDataManager.updateItems(updatedMessages);
    }
  }

  /// Socket
  socketConnect() {
    if (!_socketClient.isConnected) {
      _socketClient.connect();
    }
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
  void onSocketDidReceiveRoom(IMRoom room) {
    _roomDataManager.onSocketDidReceiveRoom(room);
  }

  void onSocketDidReceiveMessage(IMMessage message) {
    _roomDataManager.onSocketDidReceiveMessage(message);
    _messageDataManager.onSocketDidReceiveMessage(message);
  }

  void onSocketDidReceiveLastReadMessage(String roomId, String uid, String messageId) {
    _roomDataManager.onSocketDidReceiveLastReadMessage(roomId, uid, messageId);
    _messageDataManager.onSocketDidReceiveLastReadMessage(roomId, uid, messageId);
  }

  void onSocketDidReceiveTyping(String roomId, String uid) {}
  void onSocketDidReceiveInvitation(IMInvitation invitation) {}
  void onSocketDidReceiveCancelInvitation(String invitationId) {}
  void onSocketDidReceiveMyPrefChange(Map<String, dynamic> json) {
    _userDataManager.syncMe();
  }

  void onSocketDidReceiveRoomPref(Map<String, dynamic> json) {
    _roomDataManager.onSocketDidReceiveRoomPref(json);
  }
}
