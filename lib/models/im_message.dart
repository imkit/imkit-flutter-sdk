import 'package:imkit/models/im_user.dart';
import 'package:imkit/utils/json_from_parser.dart';
import 'package:json_annotation/json_annotation.dart';

part 'im_message.g.dart';

enum IMMessageType {
  text,
  image,
  audio,
  video,
  file,
  location,
  sticker,
  system,
  template,
  other,
}

@JsonSerializable()
class IMMessage {
  @JsonKey(name: '_id', defaultValue: '')
  String id = "";

  @JsonKey(name: 'room', defaultValue: '')
  String roomId = "";

  @JsonKey(name: 'messageType', defaultValue: IMMessageType.other, unknownEnumValue: IMMessageType.other, fromJson: _IMMessage._typeFromJson)
  IMMessageType type = IMMessageType.other;

  @JsonKey(name: 'sender', defaultValue: null)
  IMUser? sender;

  @JsonKey(name: 'mentions', defaultValue: [])
  List<String> mentions = [];

  @JsonKey(name: 'createdAtMS', defaultValue: null, fromJson: toDateTime, toJson: toTimestamp)
  DateTime? createAt;

  @JsonKey(name: 'updatedAtMS', defaultValue: null, fromJson: toDateTime, toJson: toTimestamp)
  DateTime? updateAt;

  @JsonKey(name: 'messageTimeMS', defaultValue: null, fromJson: toDateTime, toJson: toTimestamp)
  DateTime? messageAt;

  @JsonKey(name: 'message', defaultValue: null)
  String? text;

  IMMessage({
    required this.id,
    required this.roomId,
    required this.type,
    this.sender,
    this.mentions = const [],
    this.createAt,
    this.updateAt,
    this.messageAt,
    this.text,
  });

  factory IMMessage.fromJson(Map<String, dynamic> json) => _$IMMessageFromJson(json);
  Map<String, dynamic> toJson() => _$IMMessageToJson(this);
}

extension _IMMessage on IMMessage {
  static IMMessageType _typeFromJson(String value) {
    switch (value) {
      case "text":
        return IMMessageType.text;

      case "image":
        return IMMessageType.image;

      case "audio":
        return IMMessageType.audio;

      case "video":
        return IMMessageType.video;

      case "file":
        return IMMessageType.file;

      case "location":
        return IMMessageType.location;

      case "sticker":
        return IMMessageType.sticker;

      case "joinRoom":
      case "leaveRoom":
      case "addMember":
      case "deleteMember":
      case "addMembers":
      case "recall":
      case "cancelInvitations":
      case "announcement":
        return IMMessageType.system;

      case "template":
        return IMMessageType.template;

      default:
        return IMMessageType.other;
    }
  }
}
