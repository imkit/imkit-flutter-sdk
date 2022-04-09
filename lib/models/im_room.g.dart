// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'im_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IMRoom _$IMRoomFromJson(Map<String, dynamic> json) => IMRoom(
      id: json['_id'] as String? ?? '',
      type: $enumDecodeNullable(_$IMRoomTypeEnumMap, json['roomType'],
              unknownValue: IMRoomType.direct) ??
          IMRoomType.direct,
      name: json['name'] as String? ?? '',
      desc: json['description'] as String?,
      coverUrl: json['cover'] as String?,
      numberOfUnreadMessages: json['unread'] as int? ?? 0,
      isMuted: json['muted'] as bool? ?? false,
      isMentioned: json['isMentioned'] as bool? ?? false,
      isTranslationEnabled:
          _toIsTranslationEnabled(json, 'isTranslationEnabled') as bool? ??
              true,
      createAt: toDateTime(json['createdTimeMS'] as int),
      lastMessage: json['lastMessage'] == null
          ? null
          : IMMessage.fromJson(json['lastMessage'] as Map<String, dynamic>),
      members: (json['members'] as List<dynamic>?)
              ?.map((e) => IMUser.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      roomTags: (json['roomTags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      tags: json['pref'] == null ? const [] : _toIMTags(json['pref'] as Map?),
    );

Map<String, dynamic> _$IMRoomToJson(IMRoom instance) => <String, dynamic>{
      '_id': instance.id,
      'roomType': _$IMRoomTypeEnumMap[instance.type],
      'name': instance.name,
      'description': instance.desc,
      'cover': instance.coverUrl,
      'unread': instance.numberOfUnreadMessages,
      'muted': instance.isMuted,
      'isMentioned': instance.isMentioned,
      'isTranslationEnabled': instance.isTranslationEnabled,
      'lastMessage': instance.lastMessage,
      'members': instance.members,
      'roomTags': instance.roomTags,
      'pref': instance.tags,
      'createdTimeMS': toTimestamp(instance.createAt),
    };

const _$IMRoomTypeEnumMap = {
  IMRoomType.direct: 'direct',
  IMRoomType.group: 'group',
};
