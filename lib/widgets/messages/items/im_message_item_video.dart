import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:imkit/models/im_message.dart';
import 'package:imkit/sdk/imkit.dart';
import 'package:imkit/widgets/components/im_image_widget.dart';
import 'package:imkit/widgets/messages/items/im_message_item_component.dart';

class IMMessageItemVideo extends StatelessWidget {
  final IMMessage message;

  const IMMessageItemVideo({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) => IMImageWidget(
        url: message.images.firstOrNull?.thumbnailUrl,
        fit: BoxFit.fitWidth,
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
        onImageBuilder: (ImageProvider<Object> imageProvider) => Stack(
          children: [
            Image(image: imageProvider, fit: BoxFit.cover),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.play_circle_fill_outlined,
                  size: 44,
                  color: IMKit.style.primaryColor,
                ),
              ),
            ),
          ],
        ),
      );
}
