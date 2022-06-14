import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:imkit/models/im_file.dart';

class IMFileConverter extends TypeConverter<IMFile?, String?> {
  @override
  IMFile? decode(String? databaseValue) {
    if (databaseValue == null) {
      return null;
    } else {
      return IMFile.fromJson(jsonDecode(databaseValue));
    }
  }

  @override
  String? encode(IMFile? value) {
    if (value == null) {
      return null;
    } else {
      return jsonEncode(value);
    }
  }
}
