import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:imkit/extensions/date_ext.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/third_party/popup_menu/src/popup_menu.dart';
import 'package:imkit/widgets/messages/im_messages_floating_action_widget.dart';
import 'package:imkit/widgets/messages/im_messages_list_item.dart';
import 'package:imkit/widgets/messages/items/im_message_item_date.dart';
import 'package:imkit/widgets/messages/items/im_message_item_menu.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

final GlobalKey<IMMessagesListWidgetState> messagesListWidgetKey = GlobalKey();

class IMMessagesListWidget extends StatefulWidget {
  final String roomId;
  final IMRoom? room;

  const IMMessagesListWidget({Key? key, required this.roomId, this.room}) : super(key: key);

  @override
  State<StatefulWidget> createState() => IMMessagesListWidgetState();
}

class IMMessagesListWidgetState extends State<IMMessagesListWidget> {
  late final AutoScrollController _controller = AutoScrollController();

  late List<IMMessage> _messages = [];
  PopupMenu? _popupMenu;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScrollControllerListener);
  }

  @override
  void dispose() {
    _controller.removeListener(_onScrollControllerListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Expanded(
        child: StreamBuilder<List<IMMessage>>(
          initialData: const [],
          stream: IMKit.instance.listener.watchMessages(roomId: widget.roomId),
          builder: (BuildContext context, AsyncSnapshot<List<IMMessage>> snapshot) {
            debugPrint(">>> message list count: ${snapshot.data?.length ?? 0}");
            // inspect(snapshot.data);
            _messages = snapshot.data ?? [];
            return ListView.separated(
              controller: _controller,
              padding: const EdgeInsets.all(8),
              itemCount: snapshot.data?.length ?? 0,
              reverse: true,
              separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 8),
              itemBuilder: (BuildContext context, int index) {
                final prevMessageCreatedAt = _messages.firstWhereIndexedOrNull((i, _) => i == index + 1)?.createdAt;
                final currentMessage = _messages[index];
                if (index == 0) {
                  IMKit.instance.action.setRead(roomId: widget.roomId, message: currentMessage);
                }
                return AutoScrollTag(
                  key: ValueKey(index),
                  index: index,
                  controller: _controller,
                  child: Column(
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
                        room: widget.room,
                        message: currentMessage,
                        onLoginPress: (itemKey, itemMenu) => _onLoginPress(context: context, itemKey: itemKey, itemMenu: itemMenu),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      );

  void jumpTo(IMMessage message) => _scrollTo(_messages.indexWhere((element) => element.id == message.id));
  void jumpToBottom() => _scrollTo(0);
}

extension on IMMessagesListWidgetState {
  void _onLoginPress({required BuildContext context, required GlobalKey itemKey, required IMMessageItemMenu itemMenu}) {
    if (_popupMenu != null) {
      _popupMenu?.dismiss();
    }
    _popupMenu = itemMenu.getPopupMenu(context);
    _popupMenu?.show(widgetKey: itemKey);
  }

  void _onScrollControllerListener() {
    floatingActionWidgetKey.currentState?.updateStatus((_controller.position.pixels >= 300));
  }

  void _scrollTo(int index) {
    if (index != -1) {
      _controller.scrollToIndex(index, preferPosition: AutoScrollPosition.end);
    }
  }
}
