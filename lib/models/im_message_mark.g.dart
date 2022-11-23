// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'im_message_mark.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IMMessageMark _$IMMessageMarkFromJson(Map<String, dynamic> json) =>
    IMMessageMark(
      id: json['id'] as String,
      isDelete: json['isDelete'] as bool? ?? false,
    );

Map<String, dynamic> _$IMMessageMarkToJson(IMMessageMark instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isDelete': instance.isDelete,
    };
