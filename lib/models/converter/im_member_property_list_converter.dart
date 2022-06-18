import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:imkit/models/im_member_property.dart';

class IMMemberPropertyListConverter extends TypeConverter<List<IMMemberProperty>, String> {
  @override
  List<IMMemberProperty> decode(String databaseValue) {
    return List<IMMemberProperty>.from(jsonDecode(databaseValue).map((model) => IMMemberProperty.fromJson(model)));
  }

  @override
  String encode(List<IMMemberProperty> value) {
    return jsonEncode(serializeIMMemberPropertyList(value));
  }
}
