import 'package:imkit/models/im_room.dart';
import 'package:imkit/models/im_user.dart';
import 'package:imkit/utils/json_from_parser.dart';
import 'package:json_annotation/json_annotation.dart';

part 'im_invitation.g.dart';

@JsonSerializable()
class IMInvitation {
  @JsonKey(name: 'room', defaultValue: null)
  IMRoom? room;

  @JsonKey(name: 'inviter', defaultValue: null)
  IMUser? inviter;

  @JsonKey(name: 'createdTimeMS', defaultValue: null, fromJson: toDateTime, toJson: toTimestamp)
  DateTime? createAt;

  @JsonKey(name: 'updatedTimeMS', defaultValue: null, fromJson: toDateTime, toJson: toTimestamp)
  DateTime? updateAt;

  IMInvitation({
    this.room,
    this.inviter,
    this.createAt,
    this.updateAt,
  });

  factory IMInvitation.fromJson(Map<String, dynamic> json) => _$IMInvitationFromJson(json);
  Map<String, dynamic> toJson() => _$IMInvitationToJson(this);
}
