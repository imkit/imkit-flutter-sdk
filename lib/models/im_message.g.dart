// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'im_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IMMessage _$IMMessageFromJson(Map<String, dynamic> json) => IMMessage(
      id: json['_id'] as String? ?? '',
      roomId: json['room'] as String? ?? '',
      type: json['messageType'] == null
          ? IMMessageType.other
          : _IMMessage._typeFromJson(json['messageType'] as String),
      sender: json['sender'] == null
          ? null
          : IMUser.fromJson(json['sender'] as Map<String, dynamic>),
      createAt: toDateTime(json['createdAtMS'] as int),
      updateAt: toDateTime(json['updatedAtMS'] as int),
      messageAt: toDateTime(json['messageTimeMS'] as int),
      text: json['message'] as String?,
      mentions: (json['mentions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$IMMessageToJson(IMMessage instance) => <String, dynamic>{
      '_id': instance.id,
      'room': instance.roomId,
      'messageType': _$IMMessageTypeEnumMap[instance.type],
      'sender': instance.sender,
      'createdAtMS': toTimestamp(instance.createAt),
      'updatedAtMS': toTimestamp(instance.updateAt),
      'messageTimeMS': toTimestamp(instance.messageAt),
      'message': instance.text,
      'mentions': instance.mentions,
    };

const _$IMMessageTypeEnumMap = {
  IMMessageType.text: 'text',
  IMMessageType.image: 'image',
  IMMessageType.audio: 'audio',
  IMMessageType.video: 'video',
  IMMessageType.file: 'file',
  IMMessageType.location: 'location',
  IMMessageType.sticker: 'sticker',
  IMMessageType.system: 'system',
  IMMessageType.template: 'template',
  IMMessageType.other: 'other',
};
