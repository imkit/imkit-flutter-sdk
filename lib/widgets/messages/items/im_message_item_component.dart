import 'package:flutter/material.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:intl/intl.dart';

class IMMessageItemComponent {
  static final dateFormat = DateFormat("HH:MM");
  static final dateFormatWith12Hours = DateFormat("a h:MM");

  static double getMaxCellWidth(BuildContext context) => MediaQuery.of(context).size.width * 0.7;

  static Widget getReadReceiptAndTime({required IMMessage message}) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // I18n
          Visibility(
            visible: message.isMe,
            child: Text(/*"messages.outgoingCell.read"*/ "已讀", style: IMKit.style.message.readReceiptTextSytle),
          ),
          Visibility(
            visible: message.createdAt != null,
            child: Text(dateFormat.format(message.createdAt ?? DateTime.now()), style: IMKit.style.message.timeTextSytle),
          )
        ],
      );

  static Widget getLoadImageFailure() => Container(
        padding: const EdgeInsets.all(12),
        width: 44,
        height: 44,
        child: const Icon(Icons.broken_image_outlined),
      );
}
