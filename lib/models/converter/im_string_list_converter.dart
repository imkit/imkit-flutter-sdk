import 'dart:convert';

import 'package:floor/floor.dart';

class IMStringListConverter extends TypeConverter<List<String>, String> {
  @override
  List<String> decode(String databaseValue) {
    List list = jsonDecode(databaseValue);
    return List<String>.from(list.map((model) => model));
  }

  @override
  String encode(List<String> value) {
    return jsonEncode(value);
  }
}
