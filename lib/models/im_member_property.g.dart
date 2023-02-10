// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'im_member_property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IMMemberProperty _$IMMemberPropertyFromJson(Map<String, dynamic> json) =>
    IMMemberProperty(
      uid: json['client'] as String,
      badge: json['badge'] == null ? 0 : toInt(json['badge']),
      lastReadMessageId: json['lastRead'] as String? ?? "",
    );

Map<String, dynamic> _$IMMemberPropertyToJson(IMMemberProperty instance) =>
    <String, dynamic>{
      'client': instance.uid,
      'badge': instance.badge,
      'lastRead': instance.lastReadMessageId,
    };
