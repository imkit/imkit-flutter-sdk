import 'package:flutter/material.dart';
import 'package:imkit/gen/assets.gen.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:photo_manager/photo_manager.dart';

class IMStickerItem extends StatelessWidget {
  const IMStickerItem({
    Key? key,
    required this.entity,
    required this.option,
    this.onTap,
  }) : super(key: key);

  final AssetGenImage entity;
  final ThumbnailOption option;
  final Function(AssetGenImage)? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap?.call(entity),
      child: Positioned.fill(
          child: Image.asset(
              "packages/${IMKit.instance.internal.state.packageName}/${entity.path}")),
    );
  }
}
