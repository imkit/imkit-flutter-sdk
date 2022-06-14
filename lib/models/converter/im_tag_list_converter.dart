import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:imkit/models/im_tag.dart';

class IMTagListConverter extends TypeConverter<List<IMTag>, String> {
  @override
  List<IMTag> decode(String databaseValue) {
    return List<IMTag>.from(jsonDecode(databaseValue).map((model) => IMTag.fromJson(model)));
  }

  @override
  String encode(List<IMTag> value) {
    return jsonEncode(serializeIMTagList(value));
  }
}
