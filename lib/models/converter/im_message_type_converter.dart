import 'package:floor/floor.dart';
import 'package:imkit/models/im_message.dart';
import 'package:json_annotation/json_annotation.dart';

class IMMessageTypeConverter extends TypeConverter<IMMessageType, String> {
  @override
  IMMessageType decode(String databaseValue) {
    return $enumDecodeNullable(messageTypeMap, databaseValue, unknownValue: IMMessageType.text) ?? IMMessageType.text;
  }

  @override
  String encode(IMMessageType value) {
    return messageTypeMap[value]!;
  }
}
