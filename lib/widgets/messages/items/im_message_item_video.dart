import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:imkit/models/im_message.dart';
import 'package:imkit/sdk/imkit.dart';
import 'package:imkit/widgets/components/im_image_widget.dart';
import 'package:imkit/widgets/messages/items/im_message_item_component.dart';
import 'package:imkit/widgets/messages/sub_views/im_message_video_player.dart';

class IMMessageItemVideo extends StatelessWidget {
  final IMMessage message;
  const IMMessageItemVideo({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          final url = message.file?.url ?? "";
          if (url.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => IMMessageVideoPlayer(message: message),
                fullscreenDialog: true,
              ),
            );
          }
        },
        child: IMImageWidget(
          url: message.images.firstOrNull?.thumbnailUrl,
          fit: BoxFit.fitWidth,
          maxWidthDiskCache: IMMessageItemComponent.getMaxCellWidth(context).toInt(),
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
        ),
      );
}
