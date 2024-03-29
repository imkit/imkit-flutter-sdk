import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:imkit/sdk/imkit.dart';
import 'package:imkit/widgets/components/im_image_widget.dart';

class IMCircleAvatarWidget extends StatelessWidget {
  const IMCircleAvatarWidget({
    Key? key,
    this.url,
    this.bytes,
    this.fit = BoxFit.cover,
    this.size,
    this.width = double.infinity,
    this.height = double.infinity,
    this.text,
    this.onError,
  }) : super(key: key);

  final String? url;
  final Uint8List? bytes;
  final BoxFit fit;
  final double? size;
  final double width;
  final double height;
  final String? text;
  final Function? onError;

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        width: size ?? width,
        height: size ?? height,
        decoration: BoxDecoration(shape: BoxShape.circle, color: IMKit.style.avatar.backgroundColor),
        clipBehavior: Clip.hardEdge,
        child: IMImageWidget(
          url: url,
          bytes: bytes,
          fit: fit,
          width: size ?? width,
          height: size ?? height,
          maxWidthDiskCache: (size ?? width).toInt(),
          maxHeightDiskCache: (size ?? height).toInt(),
          text: text,
          onError: onError,
        ),
      );
}
