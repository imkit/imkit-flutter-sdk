import 'package:flutter/material.dart';
import 'package:imkit/models/im_message.dart';
import 'package:imkit/sdk/imkit.dart';
import 'package:imkit/widgets/messages/items/im_message_item_component.dart';

class IMMessageItemStatus extends StatelessWidget {
  final IMMessage message;

  const IMMessageItemStatus({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: _getChildren(),
      );

  List<Widget> _getChildren() {
    switch (message.status) {
      case IMMessageStatus.initial:
      case IMMessageStatus.sent:
        return _forSending();

      case IMMessageStatus.delivered:
        return _forDelivered();

      case IMMessageStatus.undelivered:
        return [];

      default:
        return [];
    }
  }

  List<Widget> _forSending() => [
        SizedBox(
          width: 18,
          height: 18,
          child: Icon(
            Icons.north_west,
            color: IMKit.style.message.timeTextSytle.color,
            size: 14,
          ),
        )
      ];

  List<Widget> _forDelivered() => [
        Visibility(
          visible: message.isMe,
          child: Text(IMKit.S.messages_outgoingCell_read, style: IMKit.style.message.readReceiptTextSytle),
        ),
        Visibility(
          visible: message.createdAt != null,
          child: Text(IMMessageItemComponent.dateFormat.format(message.createdAt ?? DateTime.now()), style: IMKit.style.message.timeTextSytle),
        )
      ];
}
