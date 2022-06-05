import 'package:floor/floor.dart';
import 'package:imkit/models/im_message.dart';
import 'package:json_annotation/json_annotation.dart';

class IMMessageStatusConverter extends TypeConverter<IMMessageStatus, String> {
  @override
  IMMessageStatus decode(String databaseValue) {
    return $enumDecodeNullable(messageTypeStatus, databaseValue, unknownValue: IMMessageStatus.initial) ?? IMMessageStatus.initial;
  }

  @override
  String encode(IMMessageStatus value) {
    return messageTypeStatus[value]!;
  }
}
