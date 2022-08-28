import 'package:json_annotation/json_annotation.dart';

part 'im_client.g.dart';

IMClient deserializeIMClient(Map<String, dynamic> json) => IMClient.fromJson(json);
List<IMClient> deserializeIMClientList(List<Map<String, dynamic>> json) => json.map((e) => IMClient.fromJson(e)).toList();

Map<String, dynamic> serializeIMClient(IMClient object) => object.toJson();
List<Map<String, dynamic>> serializeIMClientList(List<IMClient> objects) => objects.map((e) => e.toJson()).toList();

@JsonSerializable()
class IMClient {
  @JsonKey()
  String id;

  @JsonKey()
  String token;

  @JsonKey(defaultValue: null)
  String? nickname;

  @JsonKey(defaultValue: null)
  String? avatarUrl;

  IMClient({
    required this.id,
    required this.token,
    this.nickname,
    this.avatarUrl,
  });

  factory IMClient.fromJson(Map<String, dynamic> json) => _$IMClientFromJson(json);
  Map<String, dynamic> toJson() => _$IMClientToJson(this);
}
