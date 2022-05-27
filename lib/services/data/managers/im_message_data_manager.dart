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

  Future<void> insertItems(List<IMMessage> messages) {
    return database.messageDao.insertItems(messages);
  }
}
