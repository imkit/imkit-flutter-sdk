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
  late final AutoScrollController _controller = AutoScrollController(
    viewportBoundaryGetter: () => const Rect.fromLTRB(0, 0, 0, 8),
  );

  late List<IMMessage> _messages = [];
  late bool _isInitial = false;
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

            _messages = snapshot.data ?? [];
            int itemCount = _messages.length;
            if (itemCount > 0 && !_isInitial) {
              _isInitial = true;
              _jumpToLastReadMessage(_messages);
            }
            return ListView.separated(
              controller: _controller,
              padding: const EdgeInsets.all(8),
              itemCount: itemCount,
              separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 8),
              itemBuilder: (BuildContext context, int index) {
                final prevMessageCreatedAt = _messages.firstWhereIndexedOrNull((i, _) => i == index - 1)?.createdAt;
                final currentMessage = _messages[index];
                if (index == (itemCount - 1)) {
                  IMKit.instance.action.setRead(roomId: widget.roomId, message: currentMessage);
                }
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
        ),
      );

  Future<bool> scrollTo(String? messageId) => _scrollTo(_messages.indexWhere((element) => element.id == (messageId ?? "")), AutoScrollPosition.middle);
  Future<bool> scrollToBottom() => _scrollTo(_messages.length - 1, AutoScrollPosition.end);
  void jumpToBottom() => _controller.jumpTo(_controller.position.maxScrollExtent);
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
    double maxScroll = _controller.position.maxScrollExtent;
    double currentScroll = _controller.position.pixels;
    double delta = 300.0;
    floatingActionWidgetKey.currentState?.updateStatus(!(maxScroll - currentScroll <= delta));
  }

  Future<bool> _scrollTo(int index, AutoScrollPosition preferPosition) async {
    if (index >= 0) {
      return _controller.scrollToIndex(index, preferPosition: preferPosition).then((value) => true);
    }
    return Future.value(true);
  }

  void _jumpToLastReadMessage(List<IMMessage> messages) {
    final total = messages.length;
    final lastReadMessageIndex = messages.lastIndexWhere((element) => element.membersWhoHaveRead.contains(IMKit.uid));
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) {
        if (lastReadMessageIndex >= 0 && lastReadMessageIndex < (total - 1)) {
          scrollTo(messages[lastReadMessageIndex].id);
        } else {
          jumpToBottom();
        }
      },
    );
  }
}
