import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:imkit/models/im_response_object.dart';

class IMResponseObjectConverter extends TypeConverter<IMResponseObject?, String?> {
  @override
  IMResponseObject? decode(String? databaseValue) {
    if (databaseValue == null) {
      return null;
    } else {
      return IMResponseObject.fromJson(jsonDecode(databaseValue));
    }
  }

  @override
  String? encode(IMResponseObject? value) {
    if (value == null) {
      return null;
    } else {
      return jsonEncode(serializeIMResponseObject(value));
    }
  }
}
