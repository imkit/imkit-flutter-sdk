import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:imkit/models/im_image.dart';

class IMImageListConverter extends TypeConverter<List<IMImage>, String> {
  @override
  List<IMImage> decode(String databaseValue) {
    return List<IMImage>.from(jsonDecode(databaseValue).map((model) => IMImage.fromJson(model)));
  }

  @override
  String encode(List<IMImage> value) {
    return jsonEncode(serializeIMImageList(value));
  }
}
