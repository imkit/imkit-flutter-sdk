import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:imkit/models/im_message.dart';
import 'package:imkit/sdk/imkit.dart';
import 'package:imkit/widgets/messages/items/im_message_item_component.dart';

class IMMessageItemImage extends StatelessWidget {
  final IMMessage message;

  const IMMessageItemImage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) => CachedNetworkImage(
        imageUrl: message.images.firstOrNull?.thumbnailUrl ?? "",
        fit: BoxFit.fitWidth,
        httpHeaders: IMKit.instance.internal.state.headers(),
        errorWidget: (BuildContext context, String url, dynamic error) => IMMessageItemComponent.getLoadImageFailure(),
        progressIndicatorBuilder: (BuildContext context, String url, DownloadProgress downloadProgress) => Container(
          padding: const EdgeInsets.all(12),
          width: 44,
          height: 44,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            value: downloadProgress.progress,
          ),
        ),
      );
}
