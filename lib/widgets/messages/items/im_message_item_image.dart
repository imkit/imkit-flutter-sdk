import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:imkit/models/im_message.dart';
import 'package:imkit/widgets/components/im_image_widget.dart';
import 'package:imkit/widgets/messages/items/im_message_item_component.dart';
import 'package:imkit/widgets/messages/items/im_message_item_image_upload.dart';
import 'package:imkit/widgets/messages/sub_views/im_message_image_viewer.dart';

class IMMessageItemImage extends StatelessWidget {
  final IMMessage message;

  const IMMessageItemImage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = message.images.firstOrNull;
    if (image == null) {
      return _buildFromError();
    } else if ((image.thumbnailPath ?? "").isNotEmpty) {
      return _buildFromLocal(message: message);
    } else {
      return _buildFromUrl(context: context, url: image.thumbnailUrl, width: image.width, height: image.height);
    }
  }
}

extension on IMMessageItemImage {
  Widget _buildFromError() => IMMessageItemComponent.getLoadImageFailure();

  Widget _buildFromUrl({required BuildContext context, required String url, int? width, int? height}) => InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IMMessageImageViewer(defaultMessage: message),
            fullscreenDialog: true,
          ),
        ),
        child: IMImageWidget(
          url: url,
          fit: BoxFit.fitWidth,
          width: width?.toDouble(),
          height: (width ?? 0) <= 0 || (height ?? 0) <= 0 ? null : IMMessageItemComponent.getMaxCellWidth(context) * (height ?? 0) / (width ?? 0),
          maxWidthDiskCache: IMMessageItemComponent.getMaxCellWidth(context).toInt(),
          onError: _buildFromError,
          onProgress: (double? progress) => Center(
            child: Container(
              padding: const EdgeInsets.all(12),
              width: 44,
              height: 44,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                value: progress,
              ),
            ),
          ),
        ),
      );

  Widget _buildFromLocal({required IMMessage message}) => IMMessageItemImageUpload(message: message);
}
