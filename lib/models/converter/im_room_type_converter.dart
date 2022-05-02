import 'package:floor/floor.dart';
import 'package:imkit/models/im_room.dart';
import 'package:json_annotation/json_annotation.dart';

class IMRoomTypeConverter extends TypeConverter<IMRoomType, String> {
  @override
  IMRoomType decode(String databaseValue) {
    return $enumDecodeNullable(roomTypeMap, databaseValue, unknownValue: IMRoomType.direct) ?? IMRoomType.direct;
  }

  @override
  String encode(IMRoomType value) {
    return roomTypeMap[value]!;
  }
}
