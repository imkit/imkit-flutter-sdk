import 'package:imkit/imkit_sdk.dart';
import 'package:floor/floor.dart';
import 'package:imkit/services/db/im_base_dao.dart';

@dao
abstract class IMUserDao extends IMBaseDao<IMUser> {
  static const String table = 'IMUser';

  @Query('SELECT * FROM $table WHERE id = :id')
  Future<IMUser?> findUser(String id);
}
