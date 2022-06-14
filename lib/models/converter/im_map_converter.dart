import 'dart:convert';

import 'package:floor/floor.dart';

class IMMapConverter extends TypeConverter<Map<String, dynamic>?, String?> {
  @override
  Map<String, dynamic>? decode(String? databaseValue) {
    if (databaseValue == null) {
      return null;
    } else {
      return jsonDecode(databaseValue);
    }
  }

  @override
  String? encode(Map<String, dynamic>? value) {
    if (value == null) {
      return null;
    } else {
      return jsonEncode(value);
    }
  }
}
