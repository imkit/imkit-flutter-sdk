import 'package:imkit/models/im_message.dart';

class IMState {
  String clientKey = "";
  String chatServerURL = "";
  String translationApiKey = "";
  String bucket = "";
  String uid = "";
  String token = "";

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
  String _bucket = "chatserver-upload";
  String _uid = "";
  String _token = "";

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

  IMStateBuilder setUid(String value) {
    _uid = value;
    return this;
  }

  IMStateBuilder setToken(String value) {
    _token = value;
    return this;
  }

  IMState build() => IMState()
    ..clientKey = _clientKey
    ..chatServerURL = _chatServerURL
    ..translationApiKey = _translationApiKey
    ..bucket = _bucket
    ..uid = _uid
    ..token = _token;
}
