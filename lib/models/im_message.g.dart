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
          : _toType(json['messageType'] as String),
      systemEvent: _toSystemEvent(json, 'systemEvent') == null
          ? null
          : IMSystemEvent.fromJson(
              _toSystemEvent(json, 'systemEvent') as Map<String, dynamic>),
      sender: _toMap(json, 'sender') == null
          ? null
          : IMUser.fromJson(_toMap(json, 'sender') as Map<String, dynamic>),
      createdAt: toDateTime(_toCreatedAt(json, 'createdAtMS') as int?),
      updatedAt: toDateTime(json['updatedAtMS'] as int?),
      text: _toText(json, 'text') as String?,
      stickerId: json['sticker'] as String?,
      responseObject: _toResponseObject(json, 'responseObject') == null
          ? null
          : IMResponseObject.fromJson(_toResponseObject(json, 'responseObject')
              as Map<String, dynamic>),
      mentions: (json['mentions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      images: (_toImages(json, 'images') as List<dynamic>?)
              ?.map((e) => IMImage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      file: _toFile(json, 'file') == null
          ? null
          : IMFile.fromJson(_toFile(json, 'file') as Map<String, dynamic>),
      location: _toLocation(json, 'location') == null
          ? null
          : IMLocation.fromJson(
              _toLocation(json, 'location') as Map<String, dynamic>),
      extra: _toExtra(json, 'extra') as Map<String, dynamic>?,
      status: $enumDecodeNullable(
              _$IMMessageStatusEnumMap, _toStatus(json, 'status')) ??
          IMMessageStatus.initial,
    );

Map<String, dynamic> _$IMMessageToJson(IMMessage instance) => <String, dynamic>{
      '_id': instance.id,
      'room': instance.roomId,
      'messageType': _$IMMessageTypeEnumMap[instance.type]!,
      'systemEvent': instance.systemEvent,
      'sender': instance.sender,
      'createdAtMS': toTimestamp(instance.createdAt),
      'updatedAtMS': toTimestamp(instance.updatedAt),
      'responseObject': instance.responseObject,
      'text': instance.text,
      'sticker': instance.stickerId,
      'mentions': instance.mentions,
      'images': instance.images,
      'file': instance.file,
      'location': instance.location,
      'extra': instance.extra,
      'status': _$IMMessageStatusEnumMap[instance.status]!,
    };

const _$IMMessageStatusEnumMap = {
  IMMessageStatus.initial: 'initial',
  IMMessageStatus.preSent: 'preSent',
  IMMessageStatus.sent: 'sent',
  IMMessageStatus.delivered: 'delivered',
  IMMessageStatus.undelivered: 'undelivered',
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
