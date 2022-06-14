import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:imkit/models/im_message.dart';

class IMMessageConverter extends TypeConverter<IMMessage?, String?> {
  @override
  IMMessage? decode(String? databaseValue) {
    if (databaseValue == null) {
      return null;
    } else {
      return IMMessage.fromJson(jsonDecode(databaseValue));
    }
  }

  @override
  String? encode(IMMessage? value) {
    if (value == null) {
      return null;
    } else {
      return jsonEncode(value);
    }
  }
}
