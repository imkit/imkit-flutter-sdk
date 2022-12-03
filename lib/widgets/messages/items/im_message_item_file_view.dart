import 'package:flutter/material.dart';
import 'package:imkit/models/im_message.dart';
import 'package:imkit/sdk/imkit.dart';
import 'package:imkit/widgets/components/im_icon_button_widget.dart';

class IMMessageItemFileView extends StatelessWidget {
  final IMMessage message;

  const IMMessageItemFileView({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IMIconButtonWidget(
              icon: Icon(Icons.description_outlined, size: 24, color: IMKit.style.inputView.utility.iconColor),
              size: 24,
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(message.file?.filename ?? "", style: message.isMe ? IMKit.style.message.outgoing.textSytle : IMKit.style.message.incoming.textSytle),
                  const SizedBox(height: 2),
                  Text(message.file?.filesize ?? "", style: IMKit.style.message.file.detailTextSytle),
                ],
              ),
            ),
          ],
        ),
      );
}
