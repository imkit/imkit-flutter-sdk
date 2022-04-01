// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'im_invitation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IMInvitation _$IMInvitationFromJson(Map<String, dynamic> json) => IMInvitation(
      room: json['room'] == null
          ? null
          : IMRoom.fromJson(json['room'] as Map<String, dynamic>),
      inviter: json['inviter'] == null
          ? null
          : IMUser.fromJson(json['inviter'] as Map<String, dynamic>),
      createAt: toDateTime(json['createdTimeMS'] as int),
      updateAt: toDateTime(json['updatedTimeMS'] as int),
    );

Map<String, dynamic> _$IMInvitationToJson(IMInvitation instance) =>
    <String, dynamic>{
      'room': instance.room,
      'inviter': instance.inviter,
      'createdTimeMS': toTimestamp(instance.createAt),
      'updatedTimeMS': toTimestamp(instance.updateAt),
    };
