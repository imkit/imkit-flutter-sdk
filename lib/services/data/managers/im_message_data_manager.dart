import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/models/im_system_event.dart';
import 'package:imkit/services/data/managers/im_base_data_manager.dart';

class IMMessageDataManager extends IMBaseDataManager {
  Future<List<IMMessage>> fetchMessages({required String roomId, String? beforeMessageId, int? limit}) {
    return api.message.fetchMessages(roomId: roomId, beforeMessageId: beforeMessageId, limit: limit);
  }

  Future<List<IMMessage>> findMessages({required String roomId}) {
    return database.messageDao.findMessagesByFuture(roomId);
  }

  Future<List<IMMessage>> findMessagesByIds({required List<String> ids}) {
    return database.messageDao.findMessagesByIds(ids);
  }

  Future<IMMessage?> findMessage({required String id}) {
    return database.messageDao.findMessage(id);
  }

  Future<IMMessage?> findLatestMessage({required String roomId}) {
    return database.messageDao.findLatestMessage(roomId);
  }

  Future<void> insertItem(IMMessage message) {
    return database.messageDao.insertItem(message);
  }

  Future<void> updateItem(IMMessage message) {
    return database.messageDao.updateItem(message);
  }

  Future<void> updateItems(List<IMMessage> messages) {
    return database.messageDao.updateItems(messages);
  }

  Future<void> deleteItem(IMMessage message) {
    return database.messageDao.deleteItem(message);
  }

  Future<void> insertItems(List<IMMessage> messages) {
    return database.messageDao.insertItems(messages);
  }

  Future<IMMessage> preSendMessage({required IMMessage localMessage}) async {
    IMMessage message = localMessage;
    message.status = IMMessageStatus.sent;
    message.createdAt = DateTime.now();

    await insertItem(message);

    return message;
  }

  Future<IMMessage> sendNewMessage({required IMMessage localMessage}) async {
    try {
      final serverMessage = await _sendMessageToServer(roomId: localMessage.roomId, body: localMessage.parameters);
      await Future.wait([
        deleteItem(localMessage),
        insertItem(serverMessage),
      ]);
      return serverMessage;
    } catch (error) {
      localMessage.status = IMMessageStatus.undelivered;
      await updateItem(localMessage);

      return localMessage;
    }
  }

  Future<IMMessage> resendMessage({required IMMessage localMessage}) async {
    localMessage.status = IMMessageStatus.sent;
    await updateItem(localMessage);

    if (localMessage.type == IMMessageType.text) {
      return sendNewMessage(localMessage: localMessage);
    }
    return localMessage;
  }

  Future<IMMessage> recallMessage({required IMMessage localMessage}) async {
    final serverMessage = await _sendMessageToServer(roomId: localMessage.roomId, body: {
      "_id": localMessage.id,
      "messageType": IMMessageSystemEventType.recall.name,
    });
    await updateItem(serverMessage);

    return serverMessage;
  }

  void onSocketDidReceiveMessage(IMMessage message) {
    if (message.id.isEmpty) {
      return;
    }
    insertItem(message);
  }

  void onSocketDidReceiveLastReadMessage(String roomId, String uid, String messageId) async {
    final DateTime? lastReadMessageCreatedAt = (await findMessage(id: messageId))?.createdAt;
    if (uid == IMKit.uid || lastReadMessageCreatedAt == null) {
      return;
    }
    final List<IMMessage> messagesSentByMe = (await findMessages(roomId: roomId)).where((element) => element.sender?.id == IMKit.uid).toList();
    final List<IMMessage> descendingMessageSentByMe = messagesSentByMe.reversed.toList();
    final List<IMMessage> updatedMessages = [];

    for (var message in descendingMessageSentByMe) {
      if ((message.createdAt?.compareTo(lastReadMessageCreatedAt) ?? 0) < 0) {
        if (!message.membersWhoHaveRead.contains(uid)) {
          message.read(uid);
          updatedMessages.add(message);
        }
      }
    }
    if (updatedMessages.isNotEmpty) {
      updateItems(updatedMessages);
    }
  }
}

extension on IMMessageDataManager {
  Future<IMMessage> _sendMessageToServer({required String roomId, required Map<String, dynamic> body}) {
    return api.message.sendMessage(roomId: roomId, body: body);
  }
}
