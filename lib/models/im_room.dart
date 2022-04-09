import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/models/im_tag.dart';
import 'package:imkit/utils/json_from_parser.dart';
import 'package:json_annotation/json_annotation.dart';

part 'im_room.g.dart';

enum IMRoomType {
  @JsonValue("direct")
  direct,
  @JsonValue("group")
  group,
}

@JsonSerializable()
class IMRoom {
  @JsonKey(name: '_id', defaultValue: '')
  String id = "";

  @JsonKey(name: 'roomType', defaultValue: IMRoomType.direct, unknownEnumValue: IMRoomType.direct)
  IMRoomType type = IMRoomType.direct;

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

  @JsonKey(name: 'isMentioned')
  bool isMentioned = false;

  @JsonKey(readValue: _toIsTranslationEnabled)
  bool isTranslationEnabled = true;

  @JsonKey(name: 'lastMessage', defaultValue: null)
  IMMessage? lastMessage;

  @JsonKey(name: 'members')
  List<IMUser> members = [];

  @JsonKey(name: 'roomTags')
  List<String> roomTags = [];

  @JsonKey(name: 'pref', fromJson: _toIMTags)
  List<IMTag> tags = [];

  @JsonKey(name: 'createdTimeMS', defaultValue: null, fromJson: toDateTime, toJson: toTimestamp)
  DateTime? createAt;

  IMRoom({
    required this.id,
    required this.type,
    required this.name,
    this.desc,
    this.coverUrl,
    this.numberOfUnreadMessages = 0,
    this.isMuted = false,
    this.isMentioned = false,
    this.isTranslationEnabled = true,
    this.createAt,
    this.lastMessage,
    this.members = const [],
    this.roomTags = const [],
    this.tags = const [],
  });

  factory IMRoom.fromJson(Map<String, dynamic> json) => _$IMRoomFromJson(json);
  Map<String, dynamic> toJson() => _$IMRoomToJson(this);
}

List<IMTag> _toIMTags(Map<dynamic, dynamic>? prefs) {
  if (prefs != null) {
    final tags = prefs["tags"];
    final tagColors = prefs["tagColors"];
    if (tags != null && tagColors != null) {
      return tags.map<IMTag>((tag) => IMTag(name: tag, hexColor: tagColors[tag]?.toString())).toList();
    }
  }
  return [];
}

bool _toIsTranslationEnabled(Map<dynamic, dynamic>? map, String key) => map?["pref"]?["translation"] ?? true;

IMRoom deserializeIMRoom(Map<String, dynamic> json) => IMRoom.fromJson(json);
List<IMRoom> deserializeIMRoomList(List<Map<String, dynamic>> json) => json.map((e) => IMRoom.fromJson(e)).toList();
