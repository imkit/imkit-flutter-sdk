import 'package:floor/floor.dart';

class IMDatabaseConfig {
  static const version = 3;

  static List<Migration> migrations() {
    return [
      Migration(1, 2, (database) async {
        await database.execute('CREATE TABLE IF NOT EXISTS `IMMessageMark` (`id` TEXT NOT NULL, `isDelete` INTEGER NOT NULL, PRIMARY KEY (`id`))');
      }),
      Migration(2, 3, (database) async {
        await database.execute('ALTER TABLE `IMMessage` ADD COLUMN `translatedText` TEXT');
      }),
    ];
  }
}
