// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'im_system_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IMSystemEvent _$IMSystemEventFromJson(Map<String, dynamic> json) =>
    IMSystemEvent(
      type: $enumDecode(_$IMMessageSystemEventTypeEnumMap, json['type']),
      members: (json['members'] as List<dynamic>?)
              ?.map((e) => IMUser.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$IMSystemEventToJson(IMSystemEvent instance) =>
    <String, dynamic>{
      'type': _$IMMessageSystemEventTypeEnumMap[instance.type]!,
      'members': instance.members,
    };

const _$IMMessageSystemEventTypeEnumMap = {
  IMMessageSystemEventType.joinRoom: 'joinRoom',
  IMMessageSystemEventType.leaveRoom: 'leaveRoom',
  IMMessageSystemEventType.addMember: 'addMember',
  IMMessageSystemEventType.deleteMember: 'deleteMember',
  IMMessageSystemEventType.addMembers: 'addMembers',
  IMMessageSystemEventType.recall: 'recall',
  IMMessageSystemEventType.cancelInvitations: 'cancelInvitations',
  IMMessageSystemEventType.announcement: 'announcement',
};
