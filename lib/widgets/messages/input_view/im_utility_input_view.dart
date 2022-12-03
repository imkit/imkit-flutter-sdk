import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:imkit/sdk/imkit.dart';
import 'package:imkit/services/data/storage/im_local_storage.dart';
import 'package:imkit/widgets/common/take_location_screen.dart';
import 'package:imkit/widgets/messages/input_view/im_utility_item.dart';
import 'package:imkit/widgets/messages/input_view/im_utility_type.dart';
import 'package:imkit/widgets/messages/items/im_message_item_component.dart';

class IMUtilityInputView extends StatelessWidget {
  final Function(dynamic) onSelected;

  IMUtilityInputView({Key? key, required this.onSelected}) : super(key: key);

  final List<IMUtilityType> _types = [
    IMUtilityType.location,
    IMUtilityType.file,
    IMUtilityType.translate
  ];

  @override
  Widget build(BuildContext context) => SizedBox(
        height: IMMessageItemComponent.isPortrait(context) ? 250 : 170,
        child: GridView.custom(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, crossAxisSpacing: 0, mainAxisSpacing: 0),
          childrenDelegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) => GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async =>
                  onSelected(await onTap(context, _types[index])),
              child: IMUtilityItem(
                key: ValueKey<int>(index),
                type: _types[index],
              ),
            ),
            childCount: _types.length,
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

extension on IMUtilityInputView {
  Future<dynamic> onTap(BuildContext context, IMUtilityType type) {
    switch (type) {
      case IMUtilityType.location:
        return Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const TakeLocationScreen()));

      case IMUtilityType.file:
        return FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf'],
        );

      case IMUtilityType.translate:
        return Future(() {
          bool enable = !IMKit.instance.internal.state.cloudTranslateActive;
          IMKit.instance.internal.state.cloudTranslateActive = enable;
          IMKit.instance.internal.data.localStorege
              .setValue(key: IMLocalStoregeKey.enableTranslate, value: enable);
        });
    }
  }
}
