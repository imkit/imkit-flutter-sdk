import 'package:imkit/imkit_sdk.dart';
import 'package:floor/floor.dart';
import 'package:imkit/services/db/im_base_dao.dart';

@dao
abstract class IMMessageDao extends IMBaseDao<IMMessage> {
  static const String table = 'IMMessage';

  @Query('SELECT * FROM $table WHERE roomId = :roomId ORDER BY createdAt ASC')
  Stream<List<IMMessage>> findMessages(String roomId);

  @Query('SELECT * FROM $table WHERE roomId = :roomId ORDER BY createdAt DESC')
  Stream<List<IMMessage>> findMessagesDESC(String roomId);

  @Query('SELECT * FROM $table WHERE roomId = :roomId AND type = :type ORDER BY createdAt ASC')
  Stream<List<IMMessage>> findMessagesByType(String roomId, IMMessageType type);

  @Query('SELECT * FROM $table WHERE roomId = :roomId ORDER BY createdAt ASC')
  Future<List<IMMessage>> findMessagesByFuture(String roomId);

  @Query('SELECT * FROM $table WHERE (id IN (:ids))')
  Future<List<IMMessage>> findMessagesByIds(List<String> ids);

  @Query('SELECT * FROM $table WHERE roomId = :roomId ORDER BY createdAt DESC LIMIT 1')
  Future<IMMessage?> findLatestMessage(String roomId);

  @Query('SELECT * FROM $table WHERE id = :id')
  Future<IMMessage?> findMessage(String id);

  @Query('DELETE FROM $table WHERE roomId = :roomId')
  Future<void> deleteByRoom(String roomId);

  @Query('DELETE FROM $table')
  Future<void> deleteAll();
}
