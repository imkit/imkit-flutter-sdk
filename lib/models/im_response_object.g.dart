// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'im_response_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IMResponseObject _$IMResponseObjectFromJson(Map<String, dynamic> json) =>
    IMResponseObject(
      id: json['_id'] as String? ?? '',
      messageType: json['messageType'] as String? ?? "",
      message: _toMessage(json, 'message') as String? ?? "",
      sender: json['sender'] == null
          ? null
          : IMUser.fromJson(json['sender'] as Map<String, dynamic>),
      stickerId: json['sticker'] as String?,
      imageUrl: _toImageUrl(json, 'imageUrl') as String?,
    );

Map<String, dynamic> _$IMResponseObjectToJson(IMResponseObject instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'messageType': instance.messageType,
      'message': instance.message,
      'sender': instance.sender,
      'sticker': instance.stickerId,
      'imageUrl': instance.imageUrl,
    };
