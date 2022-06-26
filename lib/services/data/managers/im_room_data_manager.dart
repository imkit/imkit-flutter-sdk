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
        room.name = IMKit.S.n_noMembers;
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
