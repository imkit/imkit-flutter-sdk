import 'package:imkit/imkit_sdk.dart';
import 'package:floor/floor.dart';
import 'package:imkit/services/db/im_base_dao.dart';

@dao
abstract class IMMessageDao extends IMBaseDao<IMMessage> {
  static const String table = 'IMMessage';

  @Query('SELECT * FROM $table WHERE roomId = :roomId ORDER BY createdAt ASC')
  Stream<List<IMMessage>> findMessages(String roomId);

  @Query('SELECT * FROM $table WHERE roomId = :roomId ORDER BY createdAt DESC LIMIT 1')
  Future<IMMessage?> findLatestMessage(String roomId);

  @Query('DELETE FROM $table WHERE roomId = :roomId')
  Future<void> deleteByRoom(String roomId);

  @Query('DELETE FROM $table')
  Future<void> deleteAll();
}
