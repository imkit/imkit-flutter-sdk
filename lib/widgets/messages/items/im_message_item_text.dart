import 'package:flutter/material.dart';
import 'package:imkit/imkit_sdk.dart';

class IMMessageItemText extends StatelessWidget {
  final IMMessage message;

  const IMMessageItemText({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Text(message.text ?? "", style: message.isMe ? IMKit.style.message.outgoing.textSytle : IMKit.style.message.incoming.textSytle),
      );
}
