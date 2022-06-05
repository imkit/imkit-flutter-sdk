import 'package:flutter/material.dart';
import 'package:imkit/sdk/imkit.dart';
import 'package:photo_manager/photo_manager.dart';

class IMPhotoItem extends StatelessWidget {
  const IMPhotoItem({
    Key? key,
    required this.entity,
    required this.option,
    required this.selectedIndex,
    this.onTap,
  }) : super(key: key);

  final AssetEntity entity;
  final ThumbnailOption option;
  final int selectedIndex;
  final Function(AssetEntity)? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap?.call(entity),
      child: Stack(
        children: [
          Positioned.fill(
            child: AssetEntityImage(
              entity,
              isOriginal: false,
              thumbnailSize: option.size,
              thumbnailFormat: option.format,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(child: Visibility(visible: selectedIndex != -1, child: Container(color: Colors.black.withOpacity(0.5)))),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 22,
              height: 22,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: selectedIndex == -1 ? Colors.transparent : IMKit.style.primaryColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: selectedIndex == -1 ? Colors.white : Colors.transparent,
                  width: 1,
                ),
              ),
              child: Text(selectedIndex == -1 ? "" : "${selectedIndex + 1}", style: IMKit.style.inputView.photo.numberTextStyle),
            ),
          )
        ],
      ),
    );
  }
}
