import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:imkit/extensions/list_ext.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/models/im_client.dart';
import 'package:imkit/models/im_file.dart';
import 'package:imkit/models/im_image.dart';
import 'package:imkit/models/im_location.dart';
import 'package:imkit/models/im_member_property.dart';
import 'package:imkit/models/im_response_object.dart';
import 'package:imkit/models/language_translate.dart';
import 'package:imkit/sdk/internal/imkit_action.dart';
import 'package:imkit/services/data/managers/language_manager.dart';
import 'package:imkit/services/data/managers/im_auth_manager.dart';
import 'package:imkit/services/data/managers/im_file_data_manager.dart';
import 'package:imkit/services/data/managers/im_message_data_manager.dart';
import 'package:imkit/services/data/managers/im_room_data_manager.dart';
import 'package:imkit/services/data/managers/im_user_manager.dart';
import 'package:imkit/services/data/storage/im_local_storage.dart';
import 'package:imkit/services/network/socket/im_socket_client.dart';
import 'package:imkit/services/network/socket/im_socket_client_event.dart';
import 'package:mime/mime.dart';
import 'package:photo_manager/photo_manager.dart';

class IMData {
  final IMState state;
  late final IMRoomDataManager _roomDataManager = IMRoomDataManager();
  late final IMMessageDataManager _messageDataManager = IMMessageDataManager();
  late final IMAuthDataManager _authDataManager = IMAuthDataManager();
  late final IMUserDataManager _userDataManager = IMUserDataManager();
  late final IMFileDataManager _fileDataManager = IMFileDataManager();
  late final LanguageDataManager _translateDataManager = LanguageDataManager();
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

  /// Auth
  Future<IMClient> getToken({required String userId}) => _authDataManager.fetchToken(userId: userId);

  /// User
  Future<IMUser> getMe() => _userDataManager.getMe();
  Future<IMUser> updateMe({String? nickname, String? avatarUrl, String? description}) => _userDataManager.updateMe(
        nickname: nickname,
        avatarUrl: avatarUrl,
        description: description,
      );

  Future<bool> subscribe({required String fcmToken}) {
    if (IMKit.uid.isNotEmpty && state.token.isNotEmpty && fcmToken.isNotEmpty) {
      return _userDataManager.subscribe(fcmToken: fcmToken);
    }
    return Future.value(false);
  }

  Future<bool> unsubscribe() {
    if (IMKit.uid.isNotEmpty && state.token.isNotEmpty) {
      return _userDataManager.unsubscribe();
    }
    return Future.value(false);
  }

  /// Room
  Future<IMRoom> createRoom({String? roomId, String? roomName, String? description, String? cover}) =>
      _roomDataManager.createRoom(roomId: roomId, roomName: roomName, description: description, cover: cover);

  Future<IMRoom> createDirectRoom(
          {required String invitee, String? roomId, String? roomName, String? description, String? cover, bool isSystemMessageEnabled = false}) =>
      _roomDataManager.createDirectRoom(
          invitee: invitee, roomId: roomId, roomName: roomName, description: description, cover: cover, isSystemMessageEnabled: isSystemMessageEnabled);

  Future<IMRoom> createGroupRoom(
          {required String roomId,
          required List<String> invitees,
          String? roomName,
          String? description,
          String? cover,
          bool isSystemMessageEnabled = true,
          bool needsInvitation = false}) =>
      _roomDataManager.createGroupRoom(
          invitees: invitees,
          roomId: roomId,
          roomName: roomName,
          description: description,
          cover: cover,
          isSystemMessageEnabled: isSystemMessageEnabled,
          needsInvitation: needsInvitation);

  Future<IMRoom> joinRoom({required String roomId, bool isSystemMessageEnabled = true}) =>
      _roomDataManager.joinRoom(roomId: roomId, isSystemMessageEnabled: isSystemMessageEnabled);

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

  Future<IMMessage> preSendImageMessages({required String roomId, required List<AssetEntity> assetEntities}) async {
    final me = await getMe();
    final images = await Future.wait(assetEntities.map((element) async {
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

    final message = IMMessage.fromImages(
      roomId: roomId,
      sender: me,
      images: images.whereNotNull().toList(),
    );
    return _messageDataManager.preSendMessage(localMessage: message);
  }

  Future<IMMessage> preSendImageMessage(
      {required String roomId, required String path, required int width, required int height, IMMessageStatus status = IMMessageStatus.preSent}) async {
    final me = await getMe();
    final image = IMImage(
      originalUrl: "",
      thumbnailUrl: "",
      width: width,
      height: height,
      originalPath: path,
      thumbnailPath: path,
    );
    final message = IMMessage.fromImages(
      roomId: roomId,
      sender: me,
      images: [image],
    );
    return _messageDataManager.preSendMessage(localMessage: message, status: status);
  }

  Future<IMImage> uploadImage({required IMImage image, UploadProgress? uploadProgress, CancelToken? cancelToken}) async {
    try {
      return _fileDataManager.uploadImage(image: image, uploadProgress: uploadProgress, cancelToken: cancelToken);
    } catch (_) {
      uploadProgress?.call(0);
      return image;
    }

    // try {
    //   await _messageDataManager.updateItem(message..status = IMMessageStatus.sent);
    //   message.images = await Future.wait(
    //     message.images.map(
    //       (element) => _fileDataManager.uploadImage(image: element, uploadProgress: uploadProgress, cancelToken: cancelToken),
    //     ),
    //   );
    //   return _messageDataManager.sendNewMessage(localMessage: message);
    // } catch (_) {
    //   uploadProgress?.call(0);
    //   _messageDataManager.updateItem(message..status = IMMessageStatus.undelivered);
    //   return message;
    // }
  }

  // Future<IMMessage> sendImageMessage({required IMMessage message, UploadProgress? uploadProgress, CancelToken? cancelToken}) async {
  //   try {
  //     await setMessageStatus(message: message, status: IMMessageStatus.sent);
  //     message.images = await Future.wait(
  //       message.images.map(
  //         (element) => _fileDataManager.uploadImage(image: element, uploadProgress: uploadProgress, cancelToken: cancelToken),
  //       ),
  //     );
  //     return _messageDataManager.sendNewMessage(localMessage: message);
  //   } catch (_) {
  //     uploadProgress?.call(0);
  //     return setMessageStatus(message: message, status: IMMessageStatus.undelivered);
  //   }
  // }

  Future<IMMessage> sendImageMessageNoUpload({required IMMessage message, required List<IMImage> images}) async {
    try {
      final successUploadedImages = images.where((element) => element.originalUrl.isNotEmpty || element.thumbnailUrl.isNotEmpty).toList();

      if (successUploadedImages.isEmpty) {
        throw Error();
      }
      await setMessageStatus(message: message, status: IMMessageStatus.sent);

      final newImageMessages = images
          .where((element) => element.originalUrl.isEmpty && element.thumbnailUrl.isEmpty)
          .map(
            (element) => preSendImageMessage(
              roomId: message.roomId,
              path: element.originalPath ?? element.thumbnailPath ?? "",
              width: element.width,
              height: element.height,
              status: IMMessageStatus.undelivered,
            ),
          )
          .toList();

      return _messageDataManager.sendNewMessage(localMessage: message..images = successUploadedImages).then(
            (value) => Future.wait(newImageMessages).then((_) => value).catchError((_) => value),
          );
    } catch (_) {
      return setMessageStatus(message: message, status: IMMessageStatus.sent);
    }
  }

  Future<IMMessage> sendLocationMessage({required String roomId, required IMLocation location, IMResponseObject? responseObject}) async {
    final IMMessage localMessage = IMMessage.fromLocation(roomId: roomId, sender: await getMe(), location: location, responseObject: responseObject);
    final newMessage = await _messageDataManager.preSendMessage(localMessage: localMessage);
    return _messageDataManager.sendNewMessage(localMessage: newMessage);
  }

  Future<IMMessage> sendStickerMessage({required String roomId, required String sticker, IMResponseObject? responseObject}) async {
    final IMMessage localMessage = IMMessage.fromSticker(roomId: roomId, sender: await getMe(), stickerId: sticker, responseObject: responseObject);
    final newMessage = await _messageDataManager.preSendMessage(localMessage: localMessage);
    return _messageDataManager.sendNewMessage(localMessage: newMessage);
  }

  Future<IMMessage> preSendAudioMessage({required String roomId, required String path, required int duration}) async {
    final me = await getMe();
    final file = File.fromUri(Uri.parse(path));

    final message = IMMessage.fromAudio(
      roomId: roomId,
      sender: me,
      localPath: file.path,
      duration: duration,
      bytes: await file.length(),
    );
    return _messageDataManager.preSendMessage(localMessage: message);
  }

  Future<IMMessage> preSendFileMessage({required String roomId, required PlatformFile platformFile, IMResponseObject? responseObject}) async {
    final me = await getMe();
    final file = IMFile(
        url: null,
        name: platformFile.name.split('.').first,
        fileExtension: platformFile.extension,
        mimeType: lookupMimeType(platformFile.path ?? "", headerBytes: platformFile.bytes),
        bytes: platformFile.size,
        duration: 0,
        originalPath: platformFile.path);
    final message = IMMessage.fromFile(
      roomId: roomId,
      sender: me,
      file: file,
    );
    return _messageDataManager.preSendMessage(localMessage: message);
  }

  Future<IMMessage> sendAndUploadFileMessage({required IMMessage message, UploadProgress? uploadProgress, CancelToken? cancelToken}) async {
    final file = message.file;
    if (file == null || (file.mimeType ?? "").isEmpty || (file.originalPath ?? "").isEmpty) {
      return message;
    }
    try {
      await _messageDataManager.updateItem(message..status = IMMessageStatus.sent);
      final uploadedFile = await _fileDataManager.upload(
        mimeType: file.mimeType!,
        file: File(file.originalPath!),
        onSendProgress: (count, total) => uploadProgress?.call(count / total),
        cancelToken: cancelToken,
      );
      message.file?.url = uploadedFile.url;
      return _messageDataManager.sendNewMessage(localMessage: message);
    } catch (_) {
      uploadProgress?.call(0);
      _messageDataManager.updateItem(message..status = IMMessageStatus.undelivered);
      return message;
    }
  }

  Future<IMMessage> resendMessage({required IMMessage message, UploadProgress? uploadProgress, CancelToken? cancelToken}) async {
    switch (message.type) {
      case IMMessageType.image:
        // return await sendImageMessage(message: message, uploadProgress: uploadProgress, cancelToken: cancelToken);
        return setMessageStatus(message: message, status: IMMessageStatus.preSent);

      case IMMessageType.audio:
      case IMMessageType.file:
        return await sendAndUploadFileMessage(message: message, uploadProgress: uploadProgress, cancelToken: cancelToken);

      case IMMessageType.text:
      case IMMessageType.location:
      case IMMessageType.sticker:
      default:
        return await _messageDataManager
            .updateItem(message..status = IMMessageStatus.sent)
            .then((_) => _messageDataManager.sendNewMessage(localMessage: message));
    }
  }

  Future<IMMessage> recallMessage({required IMMessage message}) {
    return _messageDataManager.recallMessage(localMessage: message);
  }

  Future<IMMessage> editMessage({required IMMessage message}) {
    return _messageDataManager.editMessage(localMessage: message);
  }

  Future<bool> deleteLocalMessage({required IMMessage message}) {
    return _messageDataManager.deleteLocalMessage(message: message);
  }

  void deleteMessage({required IMMessage message}) {
    _messageDataManager.deleteItem(message);
  }

  Future<IMMessage> setMessageStatus({required IMMessage message, required IMMessageStatus status}) async {
    if (message.status != status) {
      await _messageDataManager.updateItem(message..status = status);
    }
    return message;
  }

  Future<void> _syncMessages({required String roomId, int limit = 50}) async {
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

  /// File
  Future<File> downloadFileToCache({required String url, required String filename}) async =>
      (await _fileDataManager.downloadFileToCache(url: url, filename: filename));

  /// Settings
  Future<bool> leaveRoom({required String roomId}) async {
    final result = await _roomDataManager.leaveRoom(roomId: roomId, userId: IMKit.uid, isSystemMessageEnabled: true);
    await _messageDataManager.deleteByRoom(roomId);

    return result;
  }

  /// Language
  Future<LanguageTranslate> doTranslate({required String apiKey, required Map<String, dynamic> body}) =>
      _translateDataManager.doTranslate(apiKey: apiKey, body: body);

  Future<void> updateMessage({required IMMessage message}) async {
    await _messageDataManager.updateItem(message);
  }

  /// Socket
  socketConnect() {
    socketDisconnect();
    _socketClient.connect();
  }

  socketReconnectIfNeed() {
    if (!_socketClient.isConnected) {
      socketConnect();
    }
  }

  socketDisconnect() {
    if (_socketClient.isConnected) {
      _socketClient.disconnect();
    }
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
