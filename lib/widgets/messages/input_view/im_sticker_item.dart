import 'package:flutter/material.dart';
import 'package:imkit/sdk/imkit.dart';
import 'package:imkit/utils/utils.dart';
import 'package:imkit/widgets/components/im_image_widget.dart';
import 'package:imkit/widgets/messages/items/im_message_item_component.dart';

class IMStickerItem extends StatelessWidget {
  const IMStickerItem({
    Key? key,
    required this.value,
    this.width,
    this.fit,
  }) : super(key: key);

  final String? value;
  final double? width;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    if ((value ?? "").isEmpty) {
      return Container();
    }
    return Utils.isUrl(value)
        ? IMImageWidget(
            url: value,
            fit: fit,
            width: width,
            maxWidthDiskCache: width?.toInt(),
            onError: IMMessageItemComponent.getLoadImageFailure,
            onProgress: (double? progress) => Container(
              padding: const EdgeInsets.all(12),
              width: 44,
              height: 44,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                value: progress,
              ),
            ),
          )
        : Image.asset(
            value!,
            fit: fit,
            width: width,
            cacheWidth: width?.toInt(),
            package: IMKit.instance.internal.state.sdkPackageName,
          );
  }
}
