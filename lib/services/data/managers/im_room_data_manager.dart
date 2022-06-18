import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/models/im_member_property.dart';
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
}
