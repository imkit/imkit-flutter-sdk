import 'package:flutter/material.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/models/im_image.dart';
import 'package:imkit/widgets/components/im_image_widget.dart';
import 'package:imkit/widgets/messages/items/im_message_item_component.dart';
import 'package:imkit/widgets/messages/items/im_message_item_image_upload.dart';
import 'package:imkit/widgets/messages/sub_views/im_message_image_viewer.dart';

class IMMessageItemImage extends StatelessWidget {
  final IMMessage message;

  IMMessageItemImage({Key? key, required this.message}) : super(key: key);

  final List<Future<IMImage>> futureUploadImages = [];
  final double _spcing = 1;
  final double _itemHeight = 100;
  get _total => message.images.length;
  get _isOdd => _total % 2 != 0;
  get _isGrid => _total > 1;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Visibility(
            visible: _isGrid,
            child: GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _isOdd ? _total - 1 : _total,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: _spcing,
                mainAxisSpacing: _spcing,
              ),
              itemBuilder: (_, index) => SizedBox(height: _itemHeight, child: _buildWidget(context: context, image: message.images[index])),
            ),
          ),
          Visibility(
            visible: _isOdd,
            child: Container(
              margin: _isGrid ? EdgeInsets.only(top: _spcing) : null,
              height: _isGrid ? _itemHeight : null,
              child: _buildWidget(context: context, image: message.images.last),
            ),
          ),
        ],
      );
}

extension on IMMessageItemImage {
  Widget _buildWidget({required BuildContext context, required IMImage image}) {
    if ((image.thumbnailPath ?? "").isNotEmpty) {
      return _buildFromLocal(image: image);
    } else {
      return _buildFromUrl(context: context, image: image);
    }
  }

  Widget _buildFromError() => IMMessageItemComponent.getLoadImageFailure();

  Widget _buildFromUrl({required BuildContext context, required IMImage image}) => InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IMMessageImageViewer(
              roomId: message.roomId,
              selectedItem: IMMessageImageViewerItem(image: image, sender: message.sender, createdAt: message.createdAt),
            ),
            fullscreenDialog: true,
          ),
        ),
        child: IMImageWidget(
          url: image.thumbnailUrl,
          fit: BoxFit.cover,
          width: image.width.toDouble(),
          height: image.width <= 0 || image.height <= 0 ? null : IMMessageItemComponent.getMaxCellWidth(context) * image.height / image.width,
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

  Widget _buildFromLocal({required IMImage image}) => IMMessageItemImageUpload(
        isNeedToUpload: [IMMessageStatus.sent].contains(message.status),
        image: image,
        callback: (element) {
          futureUploadImages.add(element);
          if (futureUploadImages.length >= message.images.length) {
            executeUploadImages();
          }
        },
      );
}

extension on IMMessageItemImage {
  void executeUploadImages() async {
    if (![IMMessageStatus.preSent].contains(message.status)) {
      return;
    }
    final action = IMKit.instance.action;
    await action.setMessageStatus(message: message, status: IMMessageStatus.sent);
    final results = await Future.wait(futureUploadImages);
    await action.sendImageMessageNoUpload(message: message, images: results);
  }
}
