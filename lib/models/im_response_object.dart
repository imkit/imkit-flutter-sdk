import 'dart:convert';

import 'package:imkit/models/im_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'im_response_object.g.dart';

IMResponseObject deserializeIMResponseObject(Map<String, dynamic> json) => IMResponseObject.fromJson(json);
List<IMResponseObject> deserializeIMResponseObjectList(List<Map<String, dynamic>> json) => json.map((e) => IMResponseObject.fromJson(e)).toList();

@JsonSerializable()
class IMResponseObject {
  @JsonKey(name: '_id', defaultValue: '')
  String id;

  @JsonKey(name: "messageType")
  String messageType;

  @JsonKey(name: "message", readValue: _toMessage)
  String message;

  @JsonKey(name: "sender", defaultValue: null)
  IMUser? sender;

  @JsonKey(name: "sticker", defaultValue: null)
  String? stickerId;

  @JsonKey(readValue: _toImageUrl, defaultValue: null)
  String? imageUrl;

  String get text {
    switch (messageType) {
      case "image":
        // I18n
        return "n.photo";

      case "sticker":
        // I18n
        return "n.sticker";

      case "audio":
        // I18n
        return "n.voice message";

      case "video":
        // I18n
        return "n.video";
    }
    return message;
  }

  IMResponseObject({
    required this.id,
    this.messageType = "",
    this.message = "",
    this.sender,
    this.stickerId,
    this.imageUrl,
  });

  factory IMResponseObject.fromJson(Map<String, dynamic> json) => _$IMResponseObjectFromJson(json);
  Map<String, dynamic> toJson() => _$IMResponseObjectToJson(this);
}

String _toMessage(Map<dynamic, dynamic>? json, String key) {
  if (json == null) {
    return "";
  }
  final List<String> mentions = json["mentions"] ?? [];
  final extra = json["extra"];

  switch (json["messageType"]) {
    case "text":
      return mentions.join("");

    case "file":
      return "${(extra?["fileName"] ?? json["message"])}.${extra?["fileExtension"] ?? ""}";

    default:
      return json["message"];
  }
}

String? _toImageUrl(Map<dynamic, dynamic>? json, String key) => json?["thumbnailUrl"] ?? json?["originalUrl"];
