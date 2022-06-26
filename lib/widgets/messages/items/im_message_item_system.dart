import 'package:flutter/material.dart';
import 'package:imkit/models/im_message.dart';
import 'package:imkit/models/im_system_event.dart';
import 'package:imkit/sdk/imkit.dart';
import 'package:imkit/widgets/messages/items/im_message_item_component.dart';

class IMMessageItemSystem extends StatelessWidget {
  final IMMessage message;

  const IMMessageItemSystem({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: IMKit.style.message.system.backgroundColor,
          borderRadius: BorderRadius.circular(IMKit.style.message.cornerRadius),
        ),
        padding: const EdgeInsets.all(8),
        child: Text(
          _getText() ?? "",
          style: IMKit.style.message.system.textSytle,
          textAlign: TextAlign.center,
        ),
      );

  String? _getText() {
    if (message.systemEvent == null) {
      return null;
    }
    switch (message.systemEvent?.type) {
      case IMMessageSystemEventType.recall:
        return message.description;

      default:
        return "${IMMessageItemComponent.dateFormatWith12Hours.format(message.createdAt ?? DateTime.now())}\n${message.description ?? ""}";
    }
  }
}
