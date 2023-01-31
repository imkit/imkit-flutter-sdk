import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/models/im_image.dart';
import 'package:imkit/utils/imkit_cache_manager.dart';
import 'package:imkit/utils/toast.dart';
import 'package:imkit/widgets/components/im_icon_button_widget.dart';
import 'package:imkit/widgets/messages/items/im_message_item_component.dart';
import 'package:intl/intl.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class IMMessageImageViewerItem {
  IMImage image;
  IMUser? sender;
  DateTime? createdAt;

  IMMessageImageViewerItem({
    required this.image,
    this.sender,
    this.createdAt,
  });
}

// ignore: must_be_immutable
class IMMessageImageViewer extends StatelessWidget {
  final String roomId;
  final IMMessageImageViewerItem selectedItem;
  late String? _currentUrl;
  late final PageController _pageController = PageController();
  late bool _isJumpToDefault = false;
  IMMessageImageViewer({Key? key, required this.roomId, required this.selectedItem}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Column(children: [
            Text(
              selectedItem.sender?.nickname ?? "",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Visibility(
              visible: selectedItem.createdAt != null,
              child: Text(
                DateFormat("yyyy/MM/dd a hh:mm:ss").format(selectedItem.createdAt ?? DateTime.now()),
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ]),
          backgroundColor: const Color.fromRGBO(0, 0, 0, 0.3),
          actions: [
            IMIconButtonWidget(
              icon: const Icon(Icons.download),
              onPressed: () async {
                final url = _currentUrl ?? "";
                if (url.isNotEmpty) {
                  final cacheManager = IMKitCacheManager();
                  FileInfo? fileInfo = await cacheManager.getFileFromCache(url);
                  fileInfo ??= await cacheManager.downloadFile(url, authHeaders: IMKit.instance.internal.state.headers());

                  final path = fileInfo.file.path;
                  final result = await PhotoManager.editor.saveImageWithPath(path, title: '');
                  final isSuccess = (result?.id ?? "").isNotEmpty;
                  if (isSuccess) {
                    Toast.basic(text: IMKit.S.p_p_saved, icon: Icons.check);
                  }
                }
              },
            )
          ],
        ),
        body: StreamBuilder<List<IMMessage>>(
          stream: IMKit.instance.listener.watchMessagesByType(roomId: roomId, type: IMMessageType.image),
          initialData: const [],
          builder: (BuildContext context, AsyncSnapshot<List<IMMessage>> snapshot) {
            final images = (snapshot.data ?? [])
                .expand((message) => message.images
                    // .where((element) => element.originalUrl.isNotEmpty || element.thumbnailUrl.isNotEmpty)
                    .map((element) => IMMessageImageViewerItem(image: element, sender: message.sender, createdAt: message.createdAt)))
                .toList();

            final index = images.indexWhere((element) => element.image.id == selectedItem.image.id);

            if (images.isNotEmpty && index >= 0 && !_isJumpToDefault) {
              _isJumpToDefault = true;
              Future.delayed(const Duration(milliseconds: 5), () => _pageController.jumpToPage(index));
            }

            return Container(
              color: Colors.black,
              child: PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                itemCount: images.length,
                loadingBuilder: (context, event) => _loadingWidget(progress: event == null ? 0 : event.cumulativeBytesLoaded / (event.expectedTotalBytes ?? 0)),
                builder: (BuildContext context, int index) => _getPhotoItem(item: images[index]),
                pageController: _pageController,
                onPageChanged: (index) {
                  _currentUrl = _url(item: images[index]);
                },
              ),
            );
          },
        ),
      );
}

extension on IMMessageImageViewer {
  String _url({required IMMessageImageViewerItem item}) {
    if (item.image.originalUrl.isNotEmpty) {
      return item.image.originalUrl;
    }
    return item.image.thumbnailUrl;
  }

  Widget _loadingWidget({required double progress}) => SizedBox.fromSize(
        size: const Size.square(68),
        child: Stack(
          children: [
            Center(
              child: Text(
                "${(progress * 100).toInt().toString()}%",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            Center(child: CircularProgressIndicator(strokeWidth: 2, value: progress)),
          ],
        ),
      );

  PhotoViewGalleryPageOptions _getPhotoItem({required IMMessageImageViewerItem item}) {
    return PhotoViewGalleryPageOptions(
      imageProvider: CachedNetworkImageProvider(_url(item: item), headers: IMKit.instance.internal.state.headers()),
      heroAttributes: PhotoViewHeroAttributes(tag: item.image.id),
      errorBuilder: (context, error, stack) => IMMessageItemComponent.getLoadImageFailure(),
    );
  }
}
