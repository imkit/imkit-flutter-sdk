// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'im_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IMImage _$IMImageFromJson(Map<String, dynamic> json) => IMImage(
      originalUrl: json['originalUrl'] as String? ?? "",
      thumbnailUrl: json['thumbnailUrl'] as String? ?? "",
      width: json['width'] == null ? 0 : toInt(json['width']),
      height: json['height'] == null ? 0 : toInt(json['height']),
      originalPath: json['originalPath'] as String?,
      thumbnailPath: json['thumbnailPath'] as String?,
    );

Map<String, dynamic> _$IMImageToJson(IMImage instance) => <String, dynamic>{
      'originalUrl': instance.originalUrl,
      'thumbnailUrl': instance.thumbnailUrl,
      'width': instance.width,
      'height': instance.height,
      'originalPath': instance.originalPath,
      'thumbnailPath': instance.thumbnailPath,
    };
