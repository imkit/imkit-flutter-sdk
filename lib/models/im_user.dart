import 'package:floor/floor.dart';
import 'package:imkit/utils/json_from_parser.dart';
import 'package:json_annotation/json_annotation.dart';

part 'im_user.g.dart';

IMUser deserializeIMUser(Map<String, dynamic> json) => IMUser.fromJson(json);
List<IMUser> deserializeIMUserList(List<Map<String, dynamic>> json) => json.map((e) => IMUser.fromJson(e)).toList();

Map<String, dynamic> serializeIMUser(IMUser object) => object.toJson();
List<Map<String, dynamic>> serializeIMUserList(List<IMUser> objects) => objects.map((e) => e.toJson()).toList();

@JsonSerializable()
@Entity()
class IMUser {
  @PrimaryKey()
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
