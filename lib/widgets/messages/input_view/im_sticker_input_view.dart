import 'package:flutter/material.dart';
import 'package:imkit/gen/assets.gen.dart';
import 'package:imkit/widgets/messages/items/im_message_item_component.dart';
import 'package:photo_manager/photo_manager.dart';

import 'im_sticker_item.dart';

class IMStickerInputView extends StatefulWidget {
  final Function(String) onSelected;

  const IMStickerInputView({Key? key, required this.onSelected})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _IMStickerInputViewState();
}

class _IMStickerInputViewState extends State<IMStickerInputView> {
  AssetGenImage? _image;
  List<AssetGenImage>? _images;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, _requestAssets);
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        height: IMMessageItemComponent.isPortrait(context) ? 300 : 170,
        child: _buildBody(context),
      );

  Future<void> _requestAssets() async {
    final List<AssetGenImage> images = [
      Assets.stickers.sticker1,
      Assets.stickers.sticker2,
      Assets.stickers.sticker3,
      Assets.stickers.sticker4,
      Assets.stickers.sticker5,
      Assets.stickers.sticker6,
      Assets.stickers.sticker7,
      Assets.stickers.sticker8,
      Assets.stickers.sticker9,
      Assets.stickers.sticker10
    ];
    if (!mounted) {
      return;
    }
    setState(() {
      _image = images.first;
      _images = images;
    });
  }

  Widget _buildBody(BuildContext context) {
    if (_image == null || _images?.isNotEmpty != true) {
      return const Center(child: SizedBox());
    }
    return GridView.custom(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, crossAxisSpacing: 1, mainAxisSpacing: 1),
      childrenDelegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final AssetGenImage entity = _images![index];
          return IMStickerItem(
            key: ValueKey<int>(index),
            entity: entity,
            option: const ThumbnailOption(size: ThumbnailSize.square(200)),
            onTap: (entity) {
              List<String> splitPath = entity.path.split('assets/stickers/');
              if (splitPath.length > 1) {
                widget.onSelected.call(splitPath.last);
              }
            },
          );
        },
        childCount: _images!.length,
        findChildIndexCallback: (Key key) {
          if (key is ValueKey<int>) {
            return key.value;
          }
          return null;
        },
      ),
    );
  }
}
