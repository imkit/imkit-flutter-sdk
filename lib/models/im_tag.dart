import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

part 'im_tag.g.dart';

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
}
