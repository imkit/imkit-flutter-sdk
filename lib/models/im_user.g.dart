// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'im_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IMUser _$IMUserFromJson(Map<String, dynamic> json) => IMUser(
      id: json['_id'] as String? ?? '',
      nickname: json['nickname'] as String? ?? '',
      desc: json['description'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      lastLoginAt: toDateTime(json['lastLoginTimeMS'] as int?),
    );

Map<String, dynamic> _$IMUserToJson(IMUser instance) => <String, dynamic>{
      '_id': instance.id,
      'nickname': instance.nickname,
      'description': instance.desc,
      'avatarUrl': instance.avatarUrl,
      'lastLoginTimeMS': toTimestamp(instance.lastLoginAt),
    };
