import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:imkit/models/im_user.dart';

class IMUserConverter extends TypeConverter<IMUser?, String?> {
  @override
  IMUser? decode(String? databaseValue) {
    if (databaseValue == null) {
      return null;
    } else {
      return IMUser.fromJson(jsonDecode(databaseValue));
    }
  }

  @override
  String? encode(IMUser? value) {
    if (value == null) {
      return null;
    } else {
      return jsonEncode(value);
    }
  }
}
