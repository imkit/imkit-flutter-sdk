// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'im_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IMImage _$IMImageFromJson(Map<String, dynamic> json) => IMImage(
      originalUrl: json['originalUrl'] as String? ?? "",
      thumbnailUrl: json['thumbnailUrl'] as String? ?? "",
      width: json['width'] as int? ?? 0,
      height: json['height'] as int? ?? 0,
    );

Map<String, dynamic> _$IMImageToJson(IMImage instance) => <String, dynamic>{
      'originalUrl': instance.originalUrl,
      'thumbnailUrl': instance.thumbnailUrl,
      'width': instance.width,
      'height': instance.height,
    };
