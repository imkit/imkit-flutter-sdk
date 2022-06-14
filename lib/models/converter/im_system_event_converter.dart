import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:imkit/models/im_system_event.dart';

class IMSystemEventConverter extends TypeConverter<IMSystemEvent?, String?> {
  @override
  IMSystemEvent? decode(String? databaseValue) {
    if (databaseValue == null) {
      return null;
    } else {
      return IMSystemEvent.fromJson(jsonDecode(databaseValue));
    }
  }

  @override
  String? encode(IMSystemEvent? value) {
    if (value == null) {
      return null;
    } else {
      return jsonEncode(value);
    }
  }
}
