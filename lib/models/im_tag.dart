import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

part 'im_tag.g.dart';

IMTag deserializeIMTag(Map<String, dynamic> json) => IMTag.fromJson(json);
List<IMTag> deserializeIMTagList(List<Map<String, dynamic>> json) => json.map((e) => IMTag.fromJson(e)).toList();

Map<String, dynamic> serializeIMTag(IMTag object) => object.toJson();
List<Map<String, dynamic>> serializeIMTagList(List<IMTag> objects) => objects.map((e) => e.toJson()).toList();

@JsonSerializable()
class IMTag {
  String id = "";
  String name = "";
  String hexColorCode = "";

  IMTag({
    required this.name,
    String? hexColor,
  }) {
    id = md5.convert(utf8.encode("$name$hexColorCode")).toString();
    hexColorCode = hexColor ?? "#02b13f";
  }

  factory IMTag.fromJson(Map<String, dynamic> json) => _$IMTagFromJson(json);

  Map<String, dynamic> toJson() => _$IMTagToJson(this);
}
