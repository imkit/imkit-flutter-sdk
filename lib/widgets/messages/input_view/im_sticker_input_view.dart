import 'package:flutter/material.dart';
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
      _stickers = IMKit.instance.internal.state.stickers;
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
