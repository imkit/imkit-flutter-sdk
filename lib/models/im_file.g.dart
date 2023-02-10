// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'im_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IMFile _$IMFileFromJson(Map<String, dynamic> json) => IMFile(
      url: json['url'] as String?,
      name: json['name'] as String?,
      fileExtension: json['fileExtension'] as String?,
      mimeType: json['mimeType'] as String?,
      bytes: json['bytes'] == null ? 0 : toInt(json['bytes']),
      duration: json['duration'] == null ? 0 : toInt(json['duration']),
      originalPath: json['originalPath'] as String?,
    );

Map<String, dynamic> _$IMFileToJson(IMFile instance) => <String, dynamic>{
      'url': instance.url,
      'name': instance.name,
      'fileExtension': instance.fileExtension,
      'mimeType': instance.mimeType,
      'bytes': instance.bytes,
      'duration': instance.duration,
      'originalPath': instance.originalPath,
    };
