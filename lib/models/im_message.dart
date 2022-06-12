import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:floor/floor.dart';
import 'package:imkit/extensions/int_ext.dart';
import 'package:imkit/extensions/map_ext.dart';
import 'package:imkit/models/im_file.dart';
import 'package:imkit/models/im_image.dart';
import 'package:imkit/models/im_location.dart';
import 'package:imkit/models/im_response_object.dart';
import 'package:imkit/models/im_system_event.dart';
import 'package:imkit/models/im_user.dart';
import 'package:imkit/sdk/imkit.dart';
import 'package:imkit/utils/json_from_parser.dart';
import 'package:imkit/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'im_message.g.dart';

enum IMMessageType {
  text,
  image,
  audio,
  video,
  file,
  location,
  sticker,
  system,
  template,
  other,
}

enum IMMessageStatus {
  initial,
  sent,
  delivered,
  undelivered,
}

IMMessage deserializeIMMessage(Map<String, dynamic> json) => IMMessage.fromJson(json);
List<IMMessage> deserializeIMMessageList(List<Map<String, dynamic>> json) => json.map((e) => IMMessage.fromJson(e)).toList();

Map<String, dynamic> serializeIMMessage(IMMessage object) => object.toJson();
List<Map<String, dynamic>> serializeIMMessageList(List<IMMessage> objects) => objects.map((e) => e.toJson()).toList();

Map<IMMessageType, String> get messageTypeMap => _$IMMessageTypeEnumMap;
Map<IMMessageStatus, String> get messageTypeStatus => _$IMMessageStatusEnumMap;

@JsonSerializable()
@Entity()
class IMMessage {
  @PrimaryKey()
  @JsonKey(name: '_id', defaultValue: '')
  String id = "";

  @JsonKey(name: 'room', defaultValue: '')
  String roomId = "";

  @JsonKey(name: 'messageType', defaultValue: IMMessageType.other, unknownEnumValue: IMMessageType.other, fromJson: _toType)
  IMMessageType type = IMMessageType.other;

  @JsonKey(defaultValue: null, readValue: _toSystemEvent)
  IMSystemEvent? systemEvent;

  @JsonKey(name: 'sender', defaultValue: null, readValue: _toMap)
  IMUser? sender;

  @JsonKey(name: 'createdAtMS', defaultValue: null, readValue: _toCreatedAt, fromJson: toDateTime, toJson: toTimestamp)
  DateTime? createdAt;

  @JsonKey(name: 'updatedAtMS', defaultValue: null, fromJson: toDateTime, toJson: toTimestamp)
  DateTime? updatedAt;

  @JsonKey(readValue: _toResponseObject, defaultValue: null)
  IMResponseObject? responseObject;

  @JsonKey(readValue: _toText)
  String? text;

  @JsonKey(name: 'sticker', defaultValue: null)
  String? stickerId;

  @JsonKey(name: 'mentions')
  List<String> mentions = [];

  @JsonKey(readValue: _toImages)
  List<IMImage> images = [];

  @JsonKey(readValue: _toFile)
  IMFile? file;

  @JsonKey(readValue: _toLocation)
  IMLocation? location;

  @JsonKey(readValue: _toExtra)
  Map<String, dynamic>? extra;

  @JsonKey(readValue: _toStatus)
  IMMessageStatus status = IMMessageStatus.initial;

  bool get isMe => sender?.id == IMKit.uid;

  String get duration {
    if (file == null) {
      return "--:--";
    }
    return file!.duration.toTime;
  }

  String? get description {
    switch (type) {
      case IMMessageType.text:
        return text;

      case IMMessageType.image:
      case IMMessageType.audio:
      case IMMessageType.video:
      case IMMessageType.file:
      case IMMessageType.location:
      case IMMessageType.sticker:
        final map = {
          IMMessageType.image: IMKit.S.n_photo,
          IMMessageType.audio: IMKit.S.n_voice_message,
          IMMessageType.video: IMKit.S.n_video,
          IMMessageType.file: IMKit.S.n_file,
          IMMessageType.location: IMKit.S.n_location,
          IMMessageType.sticker: IMKit.S.n_sticker
        };

        if (isMe) {
          return IMKit.S.s_You_sent_a(map[type] ?? IMKit.S.n_message);
        } else {
          return IMKit.S.s_sent_a(sender?.nickname ?? "", map[type] ?? IMKit.S.n_message);
        }

      case IMMessageType.system:
        if (systemEvent == null) {
          return "";
        }
        final senderName = sender?.nickname ?? "";
        final memberName = systemEvent?.members.firstOrNull?.nickname ?? "";
        switch (systemEvent!.type) {
          case IMMessageSystemEventType.joinRoom:
            return IMKit.S.s_joined_the_chat(senderName);
          case IMMessageSystemEventType.leaveRoom:
            return IMKit.S.s_left_the_chat(senderName);
          case IMMessageSystemEventType.addMember:
            return IMKit.S.s_invited(senderName, memberName);
          case IMMessageSystemEventType.deleteMember:
            return IMKit.S.s_kicked(senderName, memberName);
          case IMMessageSystemEventType.addMembers:
            return IMKit.S.s_invited(senderName, (systemEvent?.members ?? []).map((element) => element.nickname).join(", "));
          case IMMessageSystemEventType.recall:
            return isMe ? IMKit.S.s_You_unsent_a_message : IMKit.S.s_unsent_a_message(senderName);
          case IMMessageSystemEventType.cancelInvitations:
            //I18n
            return "s.%@ canceled %@'s %#@invitationCount@ to the group." +
                senderName +
                (systemEvent?.members ?? []).map((element) => element.nickname).join(", ") +
                (systemEvent?.members.length ?? 0).toString();
          case IMMessageSystemEventType.announcement:
            return text;
        }
      case IMMessageType.template:
        return extra?["title"] ?? extra?["text"] ?? extra?["columns"]?.firstOrNull?["title"] ?? extra?["columns"]?.firstOrNull?["text"] ?? text;

      case IMMessageType.other:
        return text;
    }
  }

  Map<String, dynamic> get parameters {
    Map<String, dynamic> parameters = {"messageType": type.name};

    switch (type) {
      case IMMessageType.text:
        parameters["message"] = text;
        parameters["originalUrl"] = file?.url;
        parameters["thumbnailUrl"] = responseObject?.imageUrl;
        parameters["reply"] = responseObject?.id;
        parameters["mentions"] = mentions;
        break;

      case IMMessageType.image:
        final firstImage = images.firstOrNull;
        parameters["originalUrl"] = firstImage?.originalUrl;
        parameters["thumbnailUrl"] = firstImage?.thumbnailUrl;
        parameters["width"] = firstImage?.width;
        parameters["height"] = firstImage?.height;
        parameters["images"] = images
            .map((element) => {
                  "originalUrl": element.originalUrl,
                  "thumbnailUrl": element.thumbnailUrl,
                  "width": element.width,
                  "height": element.height,
                })
            .toList();
        break;

      case IMMessageType.audio:
      case IMMessageType.file:
        final jsonString = jsonEncode({
          "fileName": file?.name,
          "fileExtension": file?.fileExtension,
          "mimeType": file?.mimeType,
          "bytes": file?.bytes,
        }.removeNullParams);

        parameters["originalUrl"] = file?.url;
        parameters["extra"] = jsonString.replaceAll("\n", "").replaceAll(" ", "");
        parameters["duration"] = file?.duration;
        parameters["message"] = file?.name;
        break;

      case IMMessageType.video:
        final firstImage = images.firstOrNull;
        final jsonString = jsonEncode({
          "fileExtension": file?.fileExtension,
          "mimeType": file?.mimeType,
          "bytes": file?.bytes,
        }.removeNullParams);

        parameters["originalUrl"] = file?.url;
        parameters["thumbnailUrl"] = firstImage?.thumbnailUrl;
        parameters["width"] = firstImage?.width;
        parameters["height"] = firstImage?.height;
        parameters["extra"] = jsonString.replaceAll("\n", "").replaceAll(" ", "");
        parameters["duration"] = file?.duration;
        break;

      case IMMessageType.location:
        parameters["latitude"] = location?.latitude;
        parameters["longitude"] = location?.longitude;
        parameters["message"] = location?.address;
        break;

      case IMMessageType.sticker:
        parameters["sticker"] = stickerId;
        break;

      default:
        break;
    }
    return parameters.removeNullParams;
  }

  IMMessage({
    required this.id,
    required this.roomId,
    required this.type,
    this.systemEvent,
    this.sender,
    this.createdAt,
    this.updatedAt,
    this.text,
    this.stickerId,
    this.responseObject,
    this.mentions = const [],
    this.images = const [],
    this.file,
    this.location,
    this.extra,
    this.status = IMMessageStatus.initial,
  });

  factory IMMessage.fromJson(Map<String, dynamic> json) => _$IMMessageFromJson(json);
  Map<String, dynamic> toJson() => _$IMMessageToJson(this);

  factory IMMessage.fromText({
    required String roomId,
    required IMUser sender,
    required String text,
    IMResponseObject? responseObject,
    String? hiddenUrl,
    List<String> mentions = const [],
  }) =>
      IMMessage(
        id: Utils.uuid(),
        roomId: roomId,
        type: IMMessageType.text,
        sender: sender,
        responseObject: responseObject,
        file: hiddenUrl != null ? IMFile(url: hiddenUrl) : null,
        text: text,
        mentions: mentions,
      );

  factory IMMessage.fromImages({
    required String roomId,
    required IMUser sender,
    required List<IMImage> images,
  }) =>
      IMMessage(
        id: Utils.uuid(),
        roomId: roomId,
        type: IMMessageType.image,
        sender: sender,
        images: images,
      );

  factory IMMessage.fromVideo({
    required String roomId,
    required IMUser sender,
    required IMFile file,
    required IMImage image,
  }) =>
      IMMessage(
        id: Utils.uuid(),
        roomId: roomId,
        type: IMMessageType.video,
        sender: sender,
        file: file,
        images: [image],
      );

  factory IMMessage.fromSticker({
    required String roomId,
    required IMUser sender,
    required String stickerId,
  }) =>
      IMMessage(
        id: Utils.uuid(),
        roomId: roomId,
        type: IMMessageType.sticker,
        sender: sender,
        stickerId: stickerId,
      );

  factory IMMessage.fromLocation({
    required String roomId,
    required IMUser sender,
    required double longitude,
    required double latitude,
    required String address,
  }) =>
      IMMessage(
        id: Utils.uuid(),
        roomId: roomId,
        type: IMMessageType.location,
        sender: sender,
        text: address,
        location: IMLocation(longitude: longitude, latitude: latitude, address: address),
      );

  factory IMMessage.fromCustom({
    required String roomId,
    required IMUser sender,
    required IMMessageType type,
    required IMFile file,
  }) =>
      IMMessage(
        id: Utils.uuid(),
        roomId: roomId,
        type: type,
        sender: sender,
        file: file,
      );

  IMResponseObject transformToResponseObject() {
    String value = "";
    switch (type) {
      case IMMessageType.text:
        value = text ?? "";
        break;
      case IMMessageType.file:
        value = "${file?.name ?? ""}.${file?.fileExtension ?? ""}";
        break;
      case IMMessageType.location:
        value = location?.address ?? "";
        break;
      default:
        break;
    }

    return IMResponseObject(
      id: id,
      message: value,
      messageType: type.name,
      sender: sender,
      imageUrl: images.firstOrNull?.thumbnailUrl ?? images.firstOrNull?.originalUrl,
      stickerId: stickerId,
    );
  }
}

IMMessageType _toType(String value) {
  switch (value) {
    case "text":
    case "url":
      return IMMessageType.text;

    case "image":
      return IMMessageType.image;

    case "audio":
      return IMMessageType.audio;

    case "video":
      return IMMessageType.video;

    case "file":
      return IMMessageType.file;

    case "location":
      return IMMessageType.location;

    case "sticker":
      return IMMessageType.sticker;

    case "joinRoom":
    case "leaveRoom":
    case "addMember":
    case "deleteMember":
    case "addMembers":
    case "recall":
    case "cancelInvitations":
    case "announcement":
      return IMMessageType.system;

    case "template":
      return IMMessageType.template;

    default:
      return IMMessageType.other;
  }
}

Map<String, dynamic>? _toMap(Map<dynamic, dynamic>? json, String key) {
  try {
    return toMap(json?[key]);
  } catch (_) {
    return null;
  }
}

String? _toText(Map<dynamic, dynamic>? json, String key) {
  if (json == null) {
    return null;
  }
  if (json["messageType"] == "flex") {
    final List<Map<String, dynamic>> contents = json["contents"]?["body"]?["contents"] ?? [];
    final firstObject = contents.firstWhereOrNull((element) => element["type"] == "text");
    if (firstObject != null) {
      return firstObject["text"];
    }
  }
  return json["message"];
}

Map<String, dynamic>? _toSystemEvent(Map<dynamic, dynamic>? json, String key) {
  if (json == null) {
    return null;
  }
  Map<String, dynamic>? extra = toMap(json["extra"]);

  switch (json["messageType"]) {
    case "announcement":
      return IMSystemEvent(type: IMMessageSystemEventType.announcement).toJson();
    case "joinRoom":
      return IMSystemEvent(type: IMMessageSystemEventType.joinRoom).toJson();
    case "leaveRoom":
      return IMSystemEvent(type: IMMessageSystemEventType.leaveRoom).toJson();
    case "recall":
      return IMSystemEvent(type: IMMessageSystemEventType.recall).toJson();

    case "addMember":
      return IMSystemEvent(
        type: IMMessageSystemEventType.addMember,
        members: [deserializeIMUser(json["member"])],
      ).toJson();

    case "deleteMember":
      return IMSystemEvent(
        type: IMMessageSystemEventType.deleteMember,
        members: deserializeIMUserList(extra?["members"] ?? []),
      ).toJson();

    case "addMembers":
      return IMSystemEvent(
        type: IMMessageSystemEventType.addMembers,
        members: deserializeIMUserList(extra?["invitees"] ?? []),
      ).toJson();

    case "cancelInvitations":
      return IMSystemEvent(
        type: IMMessageSystemEventType.cancelInvitations,
        members: deserializeIMUserList(extra?["invitees"] ?? []),
      ).toJson();

    default:
      return null;
  }
}

Map<String, dynamic>? _toFile(Map<dynamic, dynamic>? json, String key) {
  if (json == null) {
    return null;
  }
  Map<String, dynamic>? extra = toMap(json["extra"]);
  Map<String, dynamic>? result = {};
  switch (json["messageType"]) {
    case "text":
      result["url"] = json["originalUrl"];
      break;

    case "audio":
    case "file":
    case "video":
      result["url"] = json["originalUrl"] ?? json["file"]?["url"];
      result["name"] = (extra?["fileName"] ?? json["message"])?.toString();
      result["mimeType"] = extra?["mimeType"];
      result["fileExtension"] = extra?["fileExtension"];
      result["bytes"] = extra?["bytes"] ?? 0;
      result["duration"] = json["duration"] ?? 0;
      break;
  }
  return result.isEmpty ? null : result;
}

Map<String, dynamic>? _toLocation(Map<dynamic, dynamic>? json, String key) {
  if (json?["messageType"] == "location") {
    return {"address": json?["message"] ?? "", "latitude": json?["latitude"] ?? 0, "longitude": json?["longitude"] ?? 0};
  }
  return null;
}

List<Map<String, dynamic>> _toImages(Map<dynamic, dynamic>? json, String key) {
  if (json == null) {
    return [];
  }
  switch (json["messageType"]) {
    case "image":
      if (json["images"] != null) {
        return (json["images"] as List).map((element) => Map.castFrom<dynamic, dynamic, String, dynamic>(element)).toList();
      } else {
        return [
          {
            "originalUrl": json["originalUrl"] ?? "",
            "thumbnailUrl": json["thumbnailUrl"] ?? "",
            "width": json["width"] ?? 1,
            "height": json["height"] ?? 1,
          }
        ];
      }

    case "video":
      return [
        {
          "originalUrl": "",
          "thumbnailUrl": json["thumbnailUrl"] ?? "",
          "width": json["width"] ?? 1,
          "height": json["height"] ?? 1,
        }
      ];

    default:
      return [];
  }
}

Map<String, dynamic>? _toResponseObject(Map<dynamic, dynamic>? json, String key) {
  final reply = toMap(json?["reply"]);
  if (json == null || reply == null) {
    return null;
  }
  Map<String, dynamic> map = reply;
  map["imageUrl"] =
      ["image", "video"].contains(map["messageType"]) ? map["thumbnailUrl"] ?? json["thumbnailUrl"] ?? map["originalUrl"] ?? json["originalUrl"] : null;
  map["message"] = reply["message"] ?? json["message"];
  map["extra"] = toMap(json["extra"]);
  map["mentions"] = json["mentions"];
  return map;
}

Map<String, dynamic>? _toExtra(Map<dynamic, dynamic>? json, String key) {
  if (json == null) {
    return null;
  }
  switch (json["messageType"]) {
    case "template":
      return json["template"];

    case "flex":
      return Map.castFrom<dynamic, dynamic, String, dynamic>(json);

    default:
      return toMap(json["extra"]);
  }
}

int? _toCreatedAt(Map<dynamic, dynamic>? json, String key) => json?["createdAtMS"] ?? json?["messageTimeMS"];

String _toStatus(Map<dynamic, dynamic>? json, String key) => IMMessageStatus.delivered.name;
