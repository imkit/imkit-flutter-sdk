import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:imkit/extensions/date_ext.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/models/im_message_mark.dart';
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
  late List<IMMessageMark> _messagesMark = [];
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

            return StreamBuilder<List<IMMessageMark>>(
              initialData: _messagesMark,
              stream: IMKit.instance.listener.watchMessagesMark(),
              builder: (BuildContext context, AsyncSnapshot<List<IMMessageMark>> snapshotWithMark) {
                final allMessages = snapshot.data ?? [];
                _messagesMark = snapshotWithMark.data ?? [];
                final _deleteMessageIds = _messagesMark.map((element) => element.id);
                _messages = allMessages.where((element) => !_deleteMessageIds.contains(element.id)).toList();
                final lastReciverUnReadMessage = _messages.where((element) => !element.isMe && !element.membersWhoHaveRead.contains(IMKit.uid)).firstOrNull;

                if (lastReciverUnReadMessage != null) {
                  IMKit.instance.action.setRead(roomId: widget.roomId, message: lastReciverUnReadMessage);
                }
                return ListView.separated(
                  controller: _controller,
                  padding: const EdgeInsets.all(8),
                  itemCount: _messages.length,
                  reverse: true,
                  separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 8),
                  itemBuilder: (BuildContext context, int index) {
                    final prevMessageCreatedAt = _messages.firstWhereIndexedOrNull((i, _) => i == index + 1)?.createdAt;
                    final currentMessage = _messages[index];
                    final key = ValueKey(currentMessage.id);
                    return AutoScrollTag(
                      key: key,
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
                            key: key,
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
            );
          },
        ),
      );

  Future<bool> scrollTo(String? messageId) => _scrollTo(_messages.indexWhere((element) => element.id == (messageId ?? "")), AutoScrollPosition.middle);
  refresh() => setState(() {});
  void jumpToBottom() => _controller.jumpTo(0);
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
    double currentScroll = _controller.position.pixels;
    double delta = 300.0;
    floatingActionWidgetKey.currentState?.updateStatus(currentScroll >= delta);
  }

  Future<bool> _scrollTo(int index, AutoScrollPosition preferPosition) async {
    if (index != -1) {
      return _controller.scrollToIndex(index, preferPosition: preferPosition).then((value) => true);
    }
    return Future.value(true);
  }
}
