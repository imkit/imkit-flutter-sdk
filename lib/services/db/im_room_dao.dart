import 'package:imkit/imkit_sdk.dart';
import 'package:floor/floor.dart';
import 'package:imkit/services/db/im_base_dao.dart';

@dao
abstract class IMRoomDao extends IMBaseDao<IMRoom> {
  static const String table = 'IMRoom';

  @Query('SELECT * FROM $table ORDER BY updatedAt DESC')
  Stream<List<IMRoom>> findRooms();

  @Query('SELECT * FROM $table')
  Future<List<IMRoom>> findRoomsByFuture();

  @Query('SELECT * FROM $table WHERE id = :id')
  Stream<IMRoom?> findRoom(String id);

  @Query('SELECT * FROM $table WHERE id = :id')
  Future<IMRoom?> findRoomByFuture(String id);

  @Query('DELETE FROM $table')
  Future<void> deleteAll();
}
