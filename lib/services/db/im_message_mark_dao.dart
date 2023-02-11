import 'package:floor/floor.dart';
import 'package:imkit/models/im_message_mark.dart';
import 'package:imkit/services/db/im_base_dao.dart';

@dao
abstract class IMMessageMarkDao extends IMBaseDao<IMMessageMark> {
  static const String table = 'IMMessageMark';

  @Query('SELECT * FROM $table WHERE isDelete = 1')
  Stream<List<IMMessageMark>> findDeleteMessages();

  @Query('SELECT * FROM $table WHERE isDelete = 1')
  Future<List<IMMessageMark>> findDeleteMessagesByFurure();

  @Query('DELETE FROM $table')
  Future<void> deleteAll();
}
