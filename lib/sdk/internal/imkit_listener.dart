import 'dart:async';

import 'package:imkit/models/im_room.dart';
import 'package:imkit/services/db/im_database.dart';

class IMKitListener {
  late final IMDatabase _database;

  IMKitListener(IMDatabase db) {
    _database = db;
  }

  Stream<List<IMRoom>> get watchRooms => _database.roomDao.findRooms();
}
