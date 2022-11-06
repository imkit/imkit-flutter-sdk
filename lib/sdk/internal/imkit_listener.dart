import 'dart:async';

import 'package:imkit/models/im_message.dart';
import 'package:imkit/models/im_message_mark.dart';
import 'package:imkit/models/im_room.dart';
import 'package:imkit/services/db/im_database.dart';

class IMKitListener {
  late final IMDatabase _database;

  IMKitListener(IMDatabase db) {
    _database = db;
  }

  // Room
  Stream<List<IMRoom>> get watchRooms => _database.roomDao.findRooms();
  Stream<IMRoom?> watchRoom({required String roomId}) => _database.roomDao.findRoom(roomId);

  // Message
  Stream<List<IMMessage>> watchMessages({required String roomId}) => _database.messageDao.findMessages(roomId);
  Stream<List<IMMessageMark>> watchMessagesMark() => _database.messageMarkDao.findDeleteMessages();
  Stream<List<IMMessage>> watchMessagesByType({required String roomId, required IMMessageType type}) => _database.messageDao.findMessagesByType(roomId, type);
}
