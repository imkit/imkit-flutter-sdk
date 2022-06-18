import 'package:flutter/material.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/widgets/messages/items/im_message_item_component.dart';

class IMMessageItemStatus extends StatelessWidget {
  final IMRoom? room;
  final IMMessage message;

  const IMMessageItemStatus({Key? key, this.room, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: _getChildren(),
      );
}

extension on IMMessageItemStatus {
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
          child: Text(_readReceiptText(), style: IMKit.style.message.readReceiptTextSytle),
        ),
        Visibility(
          visible: message.createdAt != null,
          child: Text(IMMessageItemComponent.dateFormat.format(message.createdAt ?? DateTime.now()), style: IMKit.style.message.timeTextSytle),
        )
      ];

  String _readReceiptText() {
    final membersWhoHaveReadCount = message.membersWhoHaveRead.length;
    String value = "";
    if (membersWhoHaveReadCount > 0) {
      value = IMKit.S.messages_outgoingCell_read;

      if (membersWhoHaveReadCount > 1 || (room?.members ?? []).length > 2) {
        value += " $membersWhoHaveReadCount";
      }
    }
    return value;
  }
}
