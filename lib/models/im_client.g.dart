// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'im_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IMClient _$IMClientFromJson(Map<String, dynamic> json) => IMClient(
      id: json['id'] as String,
      token: json['token'] as String,
      nickname: json['nickname'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$IMClientToJson(IMClient instance) => <String, dynamic>{
      'id': instance.id,
      'token': instance.token,
      'nickname': instance.nickname,
      'avatarUrl': instance.avatarUrl,
    };
