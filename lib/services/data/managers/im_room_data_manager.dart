import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/services/data/managers/im_base_data_manager.dart';

class IMRoomDataManager extends IMBaseDataManager {
  Future<List<IMRoom>> fetchRooms({required int skip, required int limit, int? lastUpdatedAt}) async {
    return api.room.fetchRooms(skip: skip, limit: limit, lastUpdatedAt: lastUpdatedAt);
  }

  Future<void> insertItem(IMRoom room) {
    return database.roomDao.insertItem(room);
  }

  Future<void> insertItems(List<IMRoom> rooms) {
    return database.roomDao.insertItems(rooms);
  }
}
