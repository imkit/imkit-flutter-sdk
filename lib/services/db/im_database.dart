import 'dart:async';

import 'package:floor/floor.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/models/converter/im_date_time_converter.dart';
import 'package:imkit/models/converter/im_file_converter.dart';
import 'package:imkit/models/converter/im_image_list_converter.dart';
import 'package:imkit/models/converter/im_location_converter.dart';
import 'package:imkit/models/converter/im_map_converter.dart';
import 'package:imkit/models/converter/im_member_property_list_converter.dart';
import 'package:imkit/models/converter/im_message_status_converter.dart';
import 'package:imkit/models/converter/im_message_type_converter.dart';
import 'package:imkit/models/converter/im_response_object_converter.dart';
import 'package:imkit/models/converter/im_room_type_converter.dart';
import 'package:imkit/models/converter/im_string_list_converter.dart';
import 'package:imkit/models/converter/im_system_event_converter.dart';
import 'package:imkit/models/converter/im_tag_list_converter.dart';
import 'package:imkit/models/converter/im_user_converter.dart';
import 'package:imkit/models/converter/im_user_list_converter.dart';
import 'package:imkit/services/db/im_message_dao.dart';
import 'package:imkit/services/db/im_room_dao.dart';
import 'package:imkit/services/db/im_user_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'im_database.g.dart';

@TypeConverters([
  IMStringListConverter,
  IMDateTimeConverter,
  IMRoomTypeConverter,
  IMUserConverter,
  IMUserListConverter,
  IMTagListConverter,
  IMMemberPropertyListConverter,
  IMMessageTypeConverter,
  IMMessageStatusConverter,
  IMSystemEventConverter,
  IMResponseObjectConverter,
  IMImageListConverter,
  IMFileConverter,
  IMLocationConverter,
  IMMapConverter,
])
@Database(version: 1, entities: [IMRoom, IMMessage, IMUser])
abstract class IMDatabase extends FloorDatabase {
  IMRoomDao get roomDao;
  IMMessageDao get messageDao;
  IMUserDao get userDao;

  // static IMDatabase? _instance;
  // static Future<IMDatabase> getInstance() async {
  //   // final migration1to2 = Migration(1, 2, (database) async {
  //   //   await database.execute('');
  //   // });
  //   _instance ??= await $FloorAppDatabase.databaseBuilder('app_database.db')
  //         .addMigrations([])
  //         .build();
  //   return _instance!;
  // }

  void clean() {
    roomDao.deleteAll();
    messageDao.deleteAll();
    userDao.deleteAll();
  }
}
