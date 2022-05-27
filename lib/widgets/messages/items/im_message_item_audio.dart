import 'package:flutter/material.dart';
import 'package:imkit/models/im_message.dart';
import 'package:imkit/sdk/imkit.dart';

class IMMessageItemAudio extends StatelessWidget {
  final IMMessage message;

  const IMMessageItemAudio({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.play_circle_fill_outlined, size: 28, color: IMKit.style.primaryColor),
          const SizedBox(width: 8),
          Text(message.duration, style: message.isMe ? IMKit.style.message.outgoing.textSytle : IMKit.style.message.incoming.textSytle)
        ],
      ),
    );
  }
}
