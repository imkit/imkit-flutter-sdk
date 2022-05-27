import 'package:imkit/imkit_sdk.dart';
import 'package:json_annotation/json_annotation.dart';

part 'im_system_event.g.dart';

enum IMMessageSystemEventType {
  @JsonValue("joinRoom")
  joinRoom,
  @JsonValue("leaveRoom")
  leaveRoom,
  @JsonValue("addMember")
  addMember,
  @JsonValue("deleteMember")
  deleteMember,
  @JsonValue("addMembers")
  addMembers,
  @JsonValue("recall")
  recall,
  @JsonValue("cancelInvitations")
  cancelInvitations,
  @JsonValue("announcement")
  announcement,
}

IMSystemEvent deserializeIMSystemEvent(Map<String, dynamic> json) => IMSystemEvent.fromJson(json);
List<IMSystemEvent> deserializeIMSystemEventList(List<Map<String, dynamic>> json) => json.map((e) => IMSystemEvent.fromJson(e)).toList();

Map<String, dynamic> serializeIMSystemEvent(IMSystemEvent object) => object.toJson();
List<Map<String, dynamic>> serializeIMSystemEventList(List<IMSystemEvent> objects) => objects.map((e) => e.toJson()).toList();

@JsonSerializable()
class IMSystemEvent {
  IMMessageSystemEventType type;
  List<IMUser> members;

  IMSystemEvent({
    required this.type,
    this.members = const [],
  });

  factory IMSystemEvent.fromJson(Map<String, dynamic> json) => _$IMSystemEventFromJson(json);
  Map<String, dynamic> toJson() => _$IMSystemEventToJson(this);
}
