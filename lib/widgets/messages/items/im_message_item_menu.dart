import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/sdk/internal/imkit_accessor.dart';
import 'package:imkit/third_party/popup_menu/popup_menu.dart';
import 'package:imkit/widgets/messages/im_messages_input_view.dart';

enum IMMessageAction {
  reply,
  forward,
  copy,
  unsend,
  edit,
  report,
}

class IMMessageItemMenu with IMAccessor {
  final IMMessage message;

  IMMessageItemMenu(this.message);

  PopupMenu getPopupMenu(BuildContext context) => PopupMenu(
        context: context,
        items: items,
        config: MenuConfig(maxColumn: 4, direction: message.isMe ? DirectionType.rtl : DirectionType.ltr),
        onClickMenu: onClickMenu,
      );
}

extension on IMMessageItemMenu {
  List<MenuItem> get items {
    List<MenuItem> items = [];
    if (state.copyableMessageTypes.contains(message.type)) {
      items.add(MenuItem(title: IMKit.S.messages_action_copy, userInfo: IMMessageAction.copy));
    }
    if (state.replyableMessageTypes.contains(message.type)) {
      items.add(MenuItem(title: IMKit.S.messages_action_reply, userInfo: IMMessageAction.reply));
    }
    if (state.editableMessageTypes.contains(message.type)) {
      items.add(MenuItem(title: IMKit.S.messages_action_edit, userInfo: IMMessageAction.edit));
    }
    if (state.unsendableMessageTypes.contains(message.type)) {
      items.add(MenuItem(title: IMKit.S.messages_action_unsend, userInfo: IMMessageAction.unsend));
    }
    if (state.forwardableMessageTypes.contains(message.type)) {
      items.add(MenuItem(title: IMKit.S.messages_action_forward, userInfo: IMMessageAction.forward));
    }
    if (state.reportableMessageTypes.contains(message.type) && !message.isMe) {
      items.add(MenuItem(title: IMKit.S.messages_action_report, userInfo: IMMessageAction.report));
    }
    return items;
  }

  void onClickMenu(MenuItemProvider item) {
    final menuItem = item as MenuItem;
    final action = menuItem.userInfo as IMMessageAction;
    switch (action) {
      case IMMessageAction.reply:
        inputViewWidgetKey.currentState?.replay(message: message);
        break;
      case IMMessageAction.forward:
        break;
      case IMMessageAction.copy:
        break;
      case IMMessageAction.unsend:
        IMKit.instance.action.recallMessage(message: message);
        break;
      case IMMessageAction.edit:
        break;
      case IMMessageAction.report:
        break;
    }
  }
}
