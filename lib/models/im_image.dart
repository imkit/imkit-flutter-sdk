import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:imkit/utils/json_from_parser.dart';
import 'package:json_annotation/json_annotation.dart';

part 'im_image.g.dart';

IMImage deserializeIMImage(Map<String, dynamic> json) => IMImage.fromJson(json);
List<IMImage> deserializeIMImageList(List<Map<String, dynamic>> json) => json.map((e) => IMImage.fromJson(e)).toList();

Map<String, dynamic> serializeIMImage(IMImage object) => object.toJson();
List<Map<String, dynamic>> serializeIMImageList(List<IMImage> objects) => objects.map((e) => e.toJson()).toList();

@JsonSerializable()
class IMImage {
  @JsonKey(name: 'originalUrl')
  String originalUrl;

  @JsonKey(name: 'thumbnailUrl')
  String thumbnailUrl;

  @JsonKey(name: 'width', fromJson: toInt)
  int width = 0;

  @JsonKey(name: 'height', fromJson: toInt)
  int height = 0;

  String? originalPath;
  String? thumbnailPath;

  String get id => md5.convert(utf8.encode("${originalUrl}_${thumbnailUrl}_${originalPath ?? ""}_${thumbnailPath ?? ""})")).toString();

  IMImage({
    this.originalUrl = "",
    this.thumbnailUrl = "",
    this.width = 0,
    this.height = 0,
    this.originalPath,
    this.thumbnailPath,
  });

  factory IMImage.fromJson(Map<String, dynamic> json) => _$IMImageFromJson(json);
  Map<String, dynamic> toJson() => _$IMImageToJson(this);
}
