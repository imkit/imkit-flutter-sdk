import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/sdk/internal/imkit_accessor.dart';
import 'package:imkit/third_party/popup_menu/popup_menu.dart' as pm;
import 'package:imkit/widgets/messages/im_messages_input_view.dart';

enum IMMessageAction {
  reply,
  forward,
  copy,
  unsend,
  edit,
  report,
  delete,
}

class IMMessageItemMenu with IMAccessor {
  final IMMessage message;

  IMMessageItemMenu(this.message);

  pm.PopupMenu getPopupMenu(BuildContext context) => pm.PopupMenu(
        context: context,
        items: items,
        config: pm.MenuConfig(maxColumn: 4, direction: message.isMe ? pm.DirectionType.rtl : pm.DirectionType.ltr),
        onClickMenu: onClickMenu,
      );
}

extension on IMMessageItemMenu {
  List<pm.MenuItem> get items {
    final isMe = message.isMe;
    List<pm.MenuItem> items = [];
    if (state.copyableMessageTypes.contains(message.type)) {
      items.add(pm.MenuItem(title: IMKit.S.messages_action_copy, userInfo: IMMessageAction.copy));
    }
    if (state.replyableMessageTypes.contains(message.type)) {
      items.add(pm.MenuItem(title: IMKit.S.messages_action_reply, userInfo: IMMessageAction.reply));
    }
    if (state.editableMessageTypes.contains(message.type) && isMe) {
      items.add(pm.MenuItem(title: IMKit.S.messages_action_edit, userInfo: IMMessageAction.edit));
    }
    if (state.unsendableMessageTypes.contains(message.type) && isMe) {
      items.add(pm.MenuItem(title: IMKit.S.messages_action_unsend, userInfo: IMMessageAction.unsend));
    }
    if (state.forwardableMessageTypes.contains(message.type)) {
      items.add(pm.MenuItem(title: IMKit.S.messages_action_forward, userInfo: IMMessageAction.forward));
    }
    if (state.reportableMessageTypes.contains(message.type) && !isMe) {
      items.add(pm.MenuItem(title: IMKit.S.messages_action_report, userInfo: IMMessageAction.report));
    }
    if (state.deleteMessageTypes.contains(message.type)) {
      items.add(pm.MenuItem(title: IMKit.S.messages_action_delete, userInfo: IMMessageAction.delete));
    }
    return items;
  }

  void onClickMenu(pm.MenuItemProvider item) {
    final menuItem = item as pm.MenuItem;
    final action = menuItem.userInfo as IMMessageAction;
    switch (action) {
      case IMMessageAction.reply:
        inputViewWidgetKey.currentState?.replay(message: message);
        break;
      case IMMessageAction.forward:
        break;
      case IMMessageAction.copy:
        Clipboard.setData(ClipboardData(text: message.text));
        break;
      case IMMessageAction.unsend:
        IMKit.instance.action.recallMessage(message: message);
        break;
      case IMMessageAction.edit:
        inputViewWidgetKey.currentState?.editingMessage(message: message);
        break;
      case IMMessageAction.report:
        break;
      case IMMessageAction.delete:
        IMKit.instance.action.deleteLocalMessage(message: message);
        break;
    }
  }
}
