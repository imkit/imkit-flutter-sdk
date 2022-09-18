import 'package:flutter/material.dart';
import 'package:imkit/models/im_message.dart';
import 'package:imkit/utils/stricker_utils.dart';
import 'package:imkit/widgets/messages/input_view/im_sticker_item.dart';
import 'package:imkit/widgets/messages/items/im_message_item_component.dart';

class IMMessageItemSticker extends StatelessWidget {
  final IMMessage message;

  const IMMessageItemSticker({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) => IMStickerItem(
        value: StrickerUtils.getStricker(message.stickerId),
        fit: BoxFit.fitWidth,
        width: IMMessageItemComponent.getStriceCellWidth(context),
      );
}
