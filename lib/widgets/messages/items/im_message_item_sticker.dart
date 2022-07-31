import 'package:flutter/material.dart';
import 'package:imkit/models/im_message.dart';
import 'package:imkit/widgets/components/im_sticker_widget.dart';

class IMMessageItemSticker extends StatelessWidget {
  final IMMessage message;

  const IMMessageItemSticker({Key? key, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (message.stickerId == null) {
      return Container();
    } else {
      return IMStickerWidget(sticker: message.stickerId);
    }
  }
}
