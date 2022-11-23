import 'package:floor/floor.dart';

class IMDatabaseConfig {
  static const version = 2;

  static List<Migration> migrations() {
    return [
      Migration(1, 2, (database) async {
        await database.execute('CREATE TABLE IF NOT EXISTS `IMMessageMark` (`id` TEXT NOT NULL, `isDelete` INTEGER NOT NULL, PRIMARY KEY (`id`))');
      }),
    ];
  }
}
