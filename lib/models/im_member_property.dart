import 'package:imkit/utils/json_from_parser.dart';
import 'package:json_annotation/json_annotation.dart';

part 'im_member_property.g.dart';

IMMemberProperty deserializeIMMemberProperty(Map<String, dynamic> json) => IMMemberProperty.fromJson(json);
List<IMMemberProperty> deserializeIMMemberPropertyList(List<Map<String, dynamic>> json) => json.map((e) => IMMemberProperty.fromJson(e)).toList();

Map<String, dynamic> serializeIMMemberProperty(IMMemberProperty object) => object.toJson();
List<Map<String, dynamic>> serializeIMMemberPropertyList(List<IMMemberProperty> objects) => objects.map((e) => e.toJson()).toList();

@JsonSerializable()
class IMMemberProperty {
  @JsonKey(name: 'client')
  String uid = "";

  @JsonKey(name: 'badge', fromJson: toInt)
  int badge = 0;

  @JsonKey(name: 'lastRead')
  String lastReadMessageId = "";

  IMMemberProperty({
    required this.uid,
    this.badge = 0,
    this.lastReadMessageId = "",
  });

  factory IMMemberProperty.fromJson(Map<String, dynamic> json) => _$IMMemberPropertyFromJson(json);
  Map<String, dynamic> toJson() => _$IMMemberPropertyToJson(this);
}
