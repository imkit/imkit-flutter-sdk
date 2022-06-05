import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/services/data/managers/im_base_data_manager.dart';

class IMMessageDataManager extends IMBaseDataManager {
  Future<List<IMMessage>> fetchMessages({required String roomId, String? beforeMessageId, int? limit}) {
    return api.message.fetchMessages(roomId: roomId, beforeMessageId: beforeMessageId, limit: limit);
  }

  Future<IMMessage?> fetchLatestMessage({required String roomId}) {
    return database.messageDao.findLatestMessage(roomId);
  }

  Future<void> insertItem(IMMessage message) {
    return database.messageDao.insertItem(message);
  }

  Future<void> updateItem(IMMessage message) {
    return database.messageDao.updateItem(message);
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

  void sendNewMessage({required IMMessage localMessage}) async {
    try {
      final serverMessage = await _sendMessageToServer(message: localMessage);
      await Future.wait([
        deleteItem(localMessage),
        insertItem(serverMessage),
      ]);
    } catch (error) {
      localMessage.status = IMMessageStatus.undelivered;
      await updateItem(localMessage);
    }
  }

  void resendMessage({required IMMessage localMessage}) async {
    localMessage.status = IMMessageStatus.sent;
    await updateItem(localMessage);

    if (localMessage.type == IMMessageType.text) {
      sendNewMessage(localMessage: localMessage);
    }
  }
}

extension on IMMessageDataManager {
  Future<IMMessage> _sendMessageToServer({required IMMessage message}) {
    return api.message.sendMessage(roomId: message.roomId, body: message.parameters);
  }
}
