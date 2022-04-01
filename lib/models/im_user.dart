import 'package:imkit/utils/json_from_parser.dart';
import 'package:json_annotation/json_annotation.dart';

part 'im_user.g.dart';

@JsonSerializable()
class IMUser {
  @JsonKey(name: '_id', defaultValue: '')
  String id = "";

  @JsonKey(name: 'nickname', defaultValue: '')
  String nickname = "";

  @JsonKey(name: 'description', defaultValue: null)
  String? desc;

  @JsonKey(name: 'avatarUrl', defaultValue: null)
  String? avatarUrl;

  @JsonKey(name: 'lastLoginTimeMS', defaultValue: null, fromJson: toDateTime, toJson: toTimestamp)
  DateTime? lastLoginAt;

  IMUser({
    required this.id,
    required this.nickname,
    this.desc,
    this.avatarUrl,
    this.lastLoginAt,
  });

  factory IMUser.fromJson(Map<String, dynamic> json) => _$IMUserFromJson(json);
  Map<String, dynamic> toJson() => _$IMUserToJson(this);
}
