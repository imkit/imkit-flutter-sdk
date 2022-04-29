// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'im_tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IMTag _$IMTagFromJson(Map<String, dynamic> json) => IMTag(
      name: json['name'] as String,
    )
      ..id = json['id'] as String
      ..hexColorCode = json['hexColorCode'] as String;

Map<String, dynamic> _$IMTagToJson(IMTag instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'hexColorCode': instance.hexColorCode,
    };
