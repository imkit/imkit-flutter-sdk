import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/models/im_message.dart';

class IMState {
  String clientKey = "";
  String chatServerURL = "";
  String translationApiKey = "";
  String cloudTranslateAPIUrl = "";
  bool cloudTranslateActive = false;
  String bucket = "";
  String uid = "";
  String token = "";
  List<String> stickers = [];
  String sdkPackageName = "";
  final String sdkDefaultPackageName = "imkit";

  List<IMMessageType> replyableMessageTypes = [
    IMMessageType.text,
    IMMessageType.image,
    IMMessageType.audio,
    IMMessageType.video,
    IMMessageType.file,
    IMMessageType.sticker,
    IMMessageType.location
  ];

  List<IMMessageType> forwardableMessageTypes = [
    // IMMessageType.text,
    // IMMessageType.image,
    // IMMessageType.audio,
    // IMMessageType.video,
    // IMMessageType.file,
  ];

  List<IMMessageType> copyableMessageTypes = [
    IMMessageType.text,
  ];

  List<IMMessageType> unsendableMessageTypes = [];

  List<IMMessageType> editableMessageTypes = [
    IMMessageType.text,
  ];

  List<IMMessageType> reportableMessageTypes = [
    // IMMessageType.text,
    // IMMessageType.image,
    // IMMessageType.audio,
    // IMMessageType.video,
    // IMMessageType.file,
  ];

  List<IMMessageType> deleteMessageTypes = [
    IMMessageType.text,
    IMMessageType.image,
    IMMessageType.audio,
    IMMessageType.video,
    IMMessageType.file,
    IMMessageType.sticker,
    IMMessageType.location
  ];

  Map<String, String> headers() {
    return {
      "IM-CLIENT-KEY": clientKey,
      "IM-Authorization": token,
    };
  }

  Map<String, String> headersForApi() {
    final apiHeaders = headers();
    apiHeaders.putIfAbsent("IM-CLIENT-ID", () => uid);
    return apiHeaders;
  }

  void logout() {
    uid = "";
    token = "";
  }
}

class IMStateBuilder {
  String _clientKey = "";
  String _chatServerURL = "";
  String _translationApiKey = "";
  String _cloudTranslateAPIUrl = "";
  bool _cloudTranslateActive = false;
  String _bucket = "chatserver-upload";
  String _uid = "";
  String _token = "";
  List<String> _stickers = [];
  String _sdkPackageName = "imkit";

  IMStateBuilder setClientKey(String value) {
    _clientKey = value;
    return this;
  }

  IMStateBuilder setChatServerURL(String value) {
    _chatServerURL = value;
    return this;
  }

  IMStateBuilder setBucket(String value) {
    _bucket = value;
    return this;
  }

  IMStateBuilder setTranslationApiKey(String value) {
    _translationApiKey = value;
    return this;
  }

  IMStateBuilder setCloudTranslateAPIUrl(String value) {
    _cloudTranslateAPIUrl = value;
    return this;
  }


  IMStateBuilder setCloudTranslateActive(bool value) {
    _cloudTranslateActive = value;
    return this;
  }

  IMStateBuilder setStickers(List<String> value) {
    _stickers = value;
    return this;
  }

  IMStateBuilder setSDKPackageName(String value) {
    _sdkPackageName = value;
    return this;
  }

  IMState build() => IMState()
    ..clientKey = _clientKey
    ..chatServerURL = _chatServerURL
    ..translationApiKey = _translationApiKey
    ..cloudTranslateAPIUrl = _cloudTranslateAPIUrl
    ..cloudTranslateActive = _cloudTranslateActive
    ..bucket = _bucket
    ..uid = _uid
    ..token = _token
    ..stickers = _stickers
    ..sdkPackageName = _sdkPackageName;
}
