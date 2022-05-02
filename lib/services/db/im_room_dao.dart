import 'package:imkit/imkit_sdk.dart';
import 'package:floor/floor.dart';
import 'package:imkit/services/db/im_base_dao.dart';

@dao
abstract class IMRoomDao extends IMBaseDao<IMRoom> {
  static const String table = 'IMRoom';

  @Query('SELECT * FROM $table ORDER BY updatedAt DESC')
  Stream<List<IMRoom>> findRooms();

  @Query('DELETE FROM $table')
  Future<void> deleteAll();
}
