import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/services/data/managers/im_base_data_manager.dart';
import 'package:imkit/services/data/storage/im_local_storage.dart';

class IMRoomDataManager extends IMBaseDataManager {
  Future<List<IMRoom>> fetchRooms({int page = 1}) async {
    const limit = 15;
    final skip = (page - 1) * limit;
    final List<IMRoom> rooms = [];
    final result = await api.room.fetchRooms(skip: skip, limit: limit, lastUpdatedAt: localStorege.getValue(key: IMLocalStoregeKey.lastRoomUpdatedAt));
    rooms.addAll(result);

    if (result.length >= limit) {
      rooms.addAll(await fetchRooms(page: page + 1));
    }
    return rooms;
  }
}
