// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'im_upload_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IMUploadFile _$IMUploadFileFromJson(Map<String, dynamic> json) => IMUploadFile(
      id: json['_id'] as String? ?? '',
      bucketName: json['bucketName'] as String? ?? '',
    );

Map<String, dynamic> _$IMUploadFileToJson(IMUploadFile instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'bucketName': instance.bucketName,
    };
