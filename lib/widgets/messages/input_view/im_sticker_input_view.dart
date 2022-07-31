import 'package:flutter/material.dart';
import 'package:imkit/gen/assets.gen.dart';
import 'package:imkit/imkit_sdk.dart';
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
  List<String>? _stickers;

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
    if (!mounted) {
      return;
    }
    setState(() {
      if (IMKit.instance.internal.state.stickers.isNotEmpty == true) {
        _stickers = IMKit.instance.internal.state.stickers;
      } else {
        String prefix = "packages/${IMKit.instance.internal.state.sdkPackageName}/";
        _stickers = [
          prefix + Assets.stickers.sticker1.path,
          prefix + Assets.stickers.sticker2.path,
          prefix + Assets.stickers.sticker3.path,
          prefix + Assets.stickers.sticker4.path,
          prefix + Assets.stickers.sticker5.path,
          prefix + Assets.stickers.sticker6.path,
          prefix + Assets.stickers.sticker7.path,
          prefix + Assets.stickers.sticker8.path,
          prefix + Assets.stickers.sticker9.path,
          prefix + Assets.stickers.sticker10.path
        ];
      }
    });
  }

  Widget _buildBody(BuildContext context) {
    if (_stickers?.isNotEmpty != true) {
      return const Center(child: SizedBox());
    }
    return GridView.custom(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, crossAxisSpacing: 1, mainAxisSpacing: 1),
      childrenDelegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final String entity = _stickers![index];
          return IMStickerItem(
            key: ValueKey<int>(index),
            entity: entity,
            option: const ThumbnailOption(size: ThumbnailSize.square(200)),
            onTap: (entity) {
              List<String> splitPath = entity.split('assets/stickers/');
              if (splitPath.length > 1) {
                widget.onSelected.call(splitPath.last);
              }
            },
          );
        },
        childCount: _stickers!.length,
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
