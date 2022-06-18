import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:imkit/models/im_location.dart';

class IMLocationConverter extends TypeConverter<IMLocation?, String?> {
  @override
  IMLocation? decode(String? databaseValue) {
    if (databaseValue == null) {
      return null;
    } else {
      return IMLocation.fromJson(jsonDecode(databaseValue));
    }
  }

  @override
  String? encode(IMLocation? value) {
    if (value == null) {
      return null;
    } else {
      return jsonEncode(serializeIMLocation(value));
    }
  }
}
