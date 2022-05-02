import 'package:collection/collection.dart';
import 'package:floor/floor.dart';
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

Map<IMRoomType, String> get roomTypeMap => _$IMRoomTypeEnumMap;

@JsonSerializable()
@Entity()
class IMRoom {
  @PrimaryKey()
  @JsonKey(name: '_id', defaultValue: '')
  String id = "";

  @JsonKey(name: 'roomType', readValue: _toRoomType, defaultValue: IMRoomType.direct, unknownEnumValue: IMRoomType.direct)
  IMRoomType type;

  @JsonKey(name: 'name', readValue: _toName, defaultValue: '')
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
  DateTime? createdAt;

  @JsonKey(name: 'updatedTimeMS', defaultValue: null, readValue: _toUpdatedAt, fromJson: toDateTime, toJson: toTimestamp)
  DateTime? updatedAt;

  String get title {
    if (type == IMRoomType.group) {
      if (members.isEmpty) {
        // I18n
        return "n.noMembers";
      } else {
        return "$name (${members.length})";
      }
    }
    // I18n
    return name.isNotEmpty ? name : "rooms.cell.emptyChat";
  }

  String get subtitle {
    return lastMessage?.description ?? "";
  }

  String get numberOfUnreadMessagesCount {
    if (numberOfUnreadMessages <= 0) {
      return "";
    } else if (numberOfUnreadMessages > 999) {
      return "999+";
    }
    return numberOfUnreadMessages.toString();
  }

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
    this.createdAt,
    this.updatedAt,
    this.lastMessage,
    this.members = const [],
    this.roomTags = const [],
    this.tags = const [],
  });

  factory IMRoom.fromJson(Map<String, dynamic> json) => _$IMRoomFromJson(json);

  Map<String, dynamic> toJson() => _$IMRoomToJson(this);
}

String _toName(Map<dynamic, dynamic>? map, String key) {
  if (map == null) {
    return "";
  }

  final String name = map["name"] ?? "";
  final List<dynamic> members = map["members"] ?? [];
  if (name.isNotEmpty) {
    return name;
  } else {
    final membersWithoutMe = members.where((element) => element["id"] != IMKit.uid);
    final membersWithoutMeLength = membersWithoutMe.length;
    final firstMember = membersWithoutMe.firstOrNull;
    if (firstMember != null && membersWithoutMeLength == 1) {
      return firstMember["nickname"] ?? "";
    } else if (membersWithoutMeLength == 0) {
      return "";
    } else {
      return membersWithoutMe.map((element) => element["nickname"] ?? "").join(", ");
    }
  }
}

String _toRoomType(Map<dynamic, dynamic>? map, String key) {
  final String roomType = map?["roomType"] ?? "";
  final Iterable members = ((map?["members"] ?? []) as List).where((element) => element["id"] != IMKit.uid);
  if (roomType.isNotEmpty) {
    return roomType;
  } else if (members.length == 1) {
    return IMRoomType.direct.name;
  } else {
    return IMRoomType.group.name;
  }
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
int? _toUpdatedAt(Map<dynamic, dynamic>? map, String key) => map?["lastMessage"]?["createdAtMS"] ?? map?["createdTimeMS"];

IMRoom deserializeIMRoom(Map<String, dynamic> json) => IMRoom.fromJson(json);
List<IMRoom> deserializeIMRoomList(List<Map<String, dynamic>> json) => json.map((e) => IMRoom.fromJson(e)).toList();
