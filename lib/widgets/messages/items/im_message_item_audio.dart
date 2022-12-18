import 'package:flutter/material.dart';
import 'package:imkit/models/im_message.dart';
import 'package:imkit/widgets/messages/items/im_message_item_audio_upload.dart';
import 'package:imkit/widgets/messages/items/im_message_item_audio_url.dart';

class IMMessageItemAudio extends StatelessWidget {
  final IMMessage message;

  const IMMessageItemAudio({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (message.status) {
      case IMMessageStatus.preSent:
      case IMMessageStatus.sent:
        return IMMessageItemAudioUpload(message: message);

      default:
        return IMMessageItemAudioUrl(message: message);
    }
  }
}
