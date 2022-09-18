import 'package:flutter/material.dart';
import 'package:imkit/utils/stricker_utils.dart';
import 'package:imkit/widgets/messages/input_view/im_sticker_item.dart';
import 'package:imkit/widgets/messages/items/im_message_item_component.dart';

class IMStickerInputView extends StatelessWidget {
  final Function(String) onSelected;
  late final Map<String, String> _stickers = StrickerUtils.allStrickers;
  late final List<String> _stickerKeys = _stickers.keys.toList();
  late final List<String> _stickerValues = _stickers.values.toList();

  IMStickerInputView({Key? key, required this.onSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        height: IMMessageItemComponent.isPortrait(context) ? 300 : 170,
        child: GridView.custom(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 16, mainAxisSpacing: 16),
          childrenDelegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) => GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onSelected.call(_stickerKeys[index]),
              child: IMStickerItem(
                key: ValueKey<int>(index),
                value: _stickerValues[index],
                fit: BoxFit.contain,
              ),
            ),
            childCount: _stickers.length,
            findChildIndexCallback: (Key key) {
              if (key is ValueKey<int>) {
                return key.value;
              }
              return null;
            },
          ),
        ),
      );
}
