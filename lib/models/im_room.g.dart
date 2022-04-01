// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'im_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IMRoom _$IMRoomFromJson(Map<String, dynamic> json) => IMRoom(
      id: json['_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      desc: json['description'] as String?,
      coverUrl: json['cover'] as String?,
      numberOfUnreadMessages: json['unread'] as int? ?? 0,
      isMuted: json['muted'] as bool? ?? false,
      createAt: toDateTime(json['createdTimeMS'] as int),
    );

Map<String, dynamic> _$IMRoomToJson(IMRoom instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.desc,
      'cover': instance.coverUrl,
      'unread': instance.numberOfUnreadMessages,
      'muted': instance.isMuted,
      'createdTimeMS': toTimestamp(instance.createAt),
    };
