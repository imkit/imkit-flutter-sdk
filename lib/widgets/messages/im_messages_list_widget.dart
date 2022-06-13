import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:imkit/extensions/date_ext.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/third_party/popup_menu/src/popup_menu.dart';
import 'package:imkit/widgets/messages/im_messages_list_item.dart';
import 'package:imkit/widgets/messages/items/im_message_item_date.dart';
import 'package:imkit/widgets/messages/items/im_message_item_menu.dart';

// ignore: must_be_immutable
class IMMessagesListWidget extends StatelessWidget {
  final String roomId;
  final IMRoom? room;
  PopupMenu? _popupMenu;

  IMMessagesListWidget({Key? key, required this.roomId, this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
        child: StreamBuilder<List<IMMessage>>(
          initialData: const [],
          stream: IMKit.instance.listener.watchMessages(roomId: roomId),
          builder: (BuildContext context, AsyncSnapshot<List<IMMessage>> snapshot) {
            print(">>> message list count: ${snapshot.data?.length ?? 0}");
            // inspect(snapshot.data);
            final messages = snapshot.data ?? [];
            return ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: snapshot.data?.length ?? 0,
              separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 8),
              itemBuilder: (BuildContext context, int index) {
                final prevMessageCreatedAt = messages.firstWhereIndexedOrNull((i, _) => i == index - 1)?.createdAt;
                final currentMessage = messages[index];

                return Column(
                  children: [
                    Visibility(
                      visible: currentMessage.createdAt?.calculateDifference(prevMessageCreatedAt) != 0,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: IMMessageItemDate(value: currentMessage.createdAt?.toMessageHeader ?? ""),
                      ),
                    ),
                    IMMessageListItem(
                      key: ValueKey(currentMessage.id),
                      room: room,
                      message: currentMessage,
                      onLoginPress: (itemKey, itemMenu) => _onLoginPress(context: context, itemKey: itemKey, itemMenu: itemMenu),
                    ),
                  ],
                );
              },
            );
          },
        ),
      );
}

extension on IMMessagesListWidget {
  void _onLoginPress({required BuildContext context, required GlobalKey itemKey, required IMMessageItemMenu itemMenu}) {
    if (_popupMenu != null) {
      _popupMenu?.dismiss();
    }
    _popupMenu = itemMenu.getPopupMenu(context);
    _popupMenu?.show(widgetKey: itemKey);
  }
}
