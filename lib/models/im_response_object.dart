import 'package:imkit/models/im_user.dart';
import 'package:imkit/sdk/imkit.dart';
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

  @JsonKey(name: "imageUrl", defaultValue: null)
  String? imageUrl;

  String get text {
    switch (messageType) {
      case "image":
        return IMKit.S.n_photo;

      case "sticker":
        return IMKit.S.n_sticker;

      case "audio":
        return IMKit.S.n_voice_message;

      case "video":
        return IMKit.S.n_video;
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
  final List<String> mentions = List<String>.from(json["mentions"] ?? []);
  final extra = json["extra"];

  switch (json["messageType"]) {
    case "text":
      return json["message"];
    //mentions.join("");

    case "file":
      return "${(extra?["fileName"] ?? json["message"])}.${extra?["fileExtension"] ?? ""}";

    default:
      return json["message"];
  }
}
