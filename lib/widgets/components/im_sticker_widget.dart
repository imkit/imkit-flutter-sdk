import 'package:flutter/material.dart';

class IMStickerWidget extends StatelessWidget {
  const IMStickerWidget({Key? key, this.sticker}) : super(key: key);

  final String? sticker;

  @override
  Widget build(BuildContext context) => _getChild();

  Widget _getChild() {
    return Image.asset("assets/stickers/$sticker");
  }
}
