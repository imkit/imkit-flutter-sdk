import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/models/im_member_property.dart';
import 'package:imkit/models/im_system_event.dart';
import 'package:imkit/models/im_tag.dart';
import 'package:imkit/services/data/managers/im_base_data_manager.dart';

class IMRoomDataManager extends IMBaseDataManager {
  Future<IMRoom> fetchRoom({required String roomId}) async {
    return api.room.fetchRoom(roomId: roomId);
  }

  Future<List<IMRoom>> fetchRooms({required int skip, required int limit, int? lastUpdatedAt}) async {
    return api.room.fetchRooms(skip: skip, limit: limit, lastUpdatedAt: lastUpdatedAt);
  }

  Future<IMMemberProperty> setRead({required String roomId, required String lastReadMessageId}) {
    return api.room.setRead(roomId: roomId, lastReadMessageId: lastReadMessageId);
  }

  Future<List<IMRoom>> findRooms() {
    return database.roomDao.findRoomsByFuture();
  }

  Future<IMRoom?> findRoom({required String roomId}) {
    return database.roomDao.findRoomByFuture(roomId);
  }

  Future<void> insertItem(IMRoom room) {
    return database.roomDao.insertItem(room);
  }

  Future<void> insertItems(List<IMRoom> rooms) {
    return database.roomDao.insertItems(rooms);
  }

  Future<void> updateItem(IMRoom room) {
    return database.roomDao.updateItem(room);
  }

  Future<IMRoom> createRoom({String? roomId, String? roomName, String? description, String? cover}) async {
    final room = await api.room.createRoom(
      roomId: roomId,
      roomName: roomName,
      description: description,
      cover: cover,
    );
    await insertItem(room);

    return room;
  }

  Future<IMRoom> createDirectRoom(
      {required String invitee, String? roomId, String? roomName, String? description, String? cover, bool isSystemMessageEnabled = false}) async {
    final room = await api.room.createDirectRoom(
      roomId: roomId ?? generateDefaultRoomID(invitee: invitee),
      roomName: roomName ?? "",
      description: description,
      invitee: invitee,
      cover: cover,
      isSystemMessageEnabled: isSystemMessageEnabled,
    );
    await insertItem(room);

    return room;
  }

  Future<IMRoom> createGroupRoom(
      {required String roomId,
      required List<String> invitees,
      String? roomName,
      String? description,
      String? cover,
      bool isSystemMessageEnabled = true,
      bool needsInvitation = false}) async {
    final room = await api.room.createGroupRoom(
      roomId: roomId,
      roomName: roomName ?? "",
      description: description,
      cover: cover,
      invitees: invitees.where((element) => element != IMKit.uid).toList(),
      isSystemMessageEnabled: isSystemMessageEnabled,
      needsInvitation: needsInvitation,
    );
    await insertItem(room);

    return room;
  }

  Future<IMRoom> joinRoom({required String roomId, bool isSystemMessageEnabled = true}) async {
    final room = await api.room.joinRoom(
      roomId: roomId,
      isSystemMessageEnabled: isSystemMessageEnabled,
    );
    await insertItem(room);

    return room;
  }

  void onSocketDidReceiveRoom(IMRoom room) {
    if (room.id.isEmpty) {
      return;
    }
    insertItem(room);
  }

  void onSocketDidReceiveMessage(IMMessage message) async {
    final room = await findRoom(roomId: message.roomId);
    if (room == null || (message.createdAt?.millisecondsSinceEpoch ?? 0) < (room.updatedAt?.millisecondsSinceEpoch ?? 0)) {
      return;
    }
    room.updatedAt = message.createdAt;

    if (message.sender?.id != IMKit.uid) {
      if (message.systemEvent?.type == IMMessageSystemEventType.deleteMember &&
          message.systemEvent?.members.indexWhere((element) => element.id == IMKit.uid) != -1) {
        room.coverUrl = "";
        room.numberOfUnreadMessages = 0;
        room.name = "";
      } else {
        room.numberOfUnreadMessages += 1;
      }
    }
    updateItem(room);
  }

  void onSocketDidReceiveLastReadMessage(String roomId, String uid, String messageId) async {
    final room = await findRoom(roomId: roomId);
    if (room != null) {
      room.numberOfUnreadMessages = 0;
      updateItem(room);
    }
  }

  void onSocketDidReceiveRoomPref(Map<String, dynamic> json) async {
    final roomId = json["room"];
    if ((roomId ?? "").isEmpty) {
      return;
    }
    final room = await findRoom(roomId: roomId);
    if (room == null) {
      return;
    }
    final tags = json["tags"];
    final tagColors = json["tagColors"];
    List<IMTag> results = [];
    if (tags != null && tagColors != null) {
      results = tags.map<IMTag>((tag) => IMTag(name: tag, hexColor: tagColors[tag]?.toString())).toList();
    }
    room.tags = results;
    updateItem(room);
  }
}

extension on IMRoomDataManager {
  String generateDefaultRoomID({required String invitee}) {
    final userIds = [IMKit.uid, invitee].map((e) => e.toLowerCase()).toList();
    userIds.sort((lhs, rhs) => lhs.compareTo(rhs));
    return md5.convert(utf8.encode(userIds.join("_"))).toString();
  }
}
