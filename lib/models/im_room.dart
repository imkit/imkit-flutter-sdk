import 'package:imkit/utils/json_from_parser.dart';
import 'package:json_annotation/json_annotation.dart';

part 'im_room.g.dart';

@JsonSerializable()
class IMRoom {
  @JsonKey(name: '_id', defaultValue: '')
  String id = "";

  @JsonKey(name: 'name', defaultValue: '')
  String name = "";

  @JsonKey(name: 'description', defaultValue: null)
  String? desc;

  @JsonKey(name: 'cover', defaultValue: null)
  String? coverUrl;

  @JsonKey(name: 'unread')
  int numberOfUnreadMessages = 0;

  @JsonKey(name: 'muted')
  bool isMuted = false;

  @JsonKey(name: 'createdTimeMS', defaultValue: null, fromJson: toDateTime, toJson: toTimestamp)
  DateTime? createAt;

  IMRoom({
    required this.id,
    required this.name,
    this.desc,
    this.coverUrl,
    this.numberOfUnreadMessages = 0,
    this.isMuted = false,
    this.createAt,
  });

  factory IMRoom.fromJson(Map<String, dynamic> json) => _$IMRoomFromJson(json);
  Map<String, dynamic> toJson() => _$IMRoomToJson(this);
}
