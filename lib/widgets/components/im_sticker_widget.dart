import 'package:flutter/material.dart';
import 'package:imkit/sdk/imkit.dart';

class IMStickerWidget extends StatelessWidget {
  const IMStickerWidget({Key? key, this.sticker}) : super(key: key);

  final String? sticker;

  @override
  Widget build(BuildContext context) => _getChild();

  Widget _getChild() {
    return Image.asset(
        "packages/${IMKit.instance.internal.state.packageName}/assets/stickers/$sticker");
  }
}
