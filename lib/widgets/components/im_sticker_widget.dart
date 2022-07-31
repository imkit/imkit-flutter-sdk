import 'package:flutter/material.dart';
import 'package:imkit/imkit_sdk.dart';

class IMStickerWidget extends StatelessWidget {
  const IMStickerWidget({Key? key, this.sticker}) : super(key: key);

  final String? sticker;

  @override
  Widget build(BuildContext context) => _getChild();

  Widget _getChild() {
    String prefix;
    if (IMKit.instance.internal.state.stickers.isNotEmpty == true) {
      prefix = "assets/stickers/";
    } else {
      prefix =
          "packages/${IMKit.instance.internal.state.sdkPackageName}/assets/stickers/";
    }

    return Image.asset("$prefix$sticker");
  }
}
