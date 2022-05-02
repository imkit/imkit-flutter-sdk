import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:imkit/models/im_user.dart';

class IMUserListConverter extends TypeConverter<List<IMUser>, String> {
  @override
  List<IMUser> decode(String databaseValue) {
    return List<IMUser>.from(jsonDecode(databaseValue).map((model) => IMUser.fromJson(model)));
  }

  @override
  String encode(List<IMUser> value) {
    return jsonEncode(serializeIMUserList(value));
  }
}
