import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class IMStickerItem extends StatelessWidget {
  const IMStickerItem({
    Key? key,
    required this.entity,
    required this.option,
    this.onTap,
  }) : super(key: key);

  final String entity;
  final ThumbnailOption option;
  final Function(String)? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap?.call(entity),
      child: Positioned.fill(child: Image.asset(entity)),
    );
  }
}
