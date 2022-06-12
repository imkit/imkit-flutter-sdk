import 'package:flutter/cupertino.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/sdk/internal/imkit_accessor.dart';
import 'package:imkit/widgets/messages/im_messages_input_view.dart';
import 'package:popup_menu/popup_menu.dart';

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
        isDown: true,
        maxColumn: 4,
        items: items,
        onClickMenu: onClickMenu,
      );
}

extension on IMMessageItemMenu {
  List<MenuItem> get items {
    List<MenuItem> items = [];
    if (state.copyableMessageTypes.contains(message.type)) {
      // I18n
      items.add(MenuItem(title: "messages.action.${IMMessageAction.copy.name}", userInfo: IMMessageAction.copy));
    }
    if (state.replyableMessageTypes.contains(message.type)) {
      // I18n
      items.add(MenuItem(title: "messages.action.${IMMessageAction.reply.name}", userInfo: IMMessageAction.reply));
    }
    if (state.editableMessageTypes.contains(message.type)) {
      // I18n
      items.add(MenuItem(title: "messages.action.${IMMessageAction.edit.name}", userInfo: IMMessageAction.edit));
    }
    if (state.unsendableMessageTypes.contains(message.type)) {
      // I18n
      items.add(MenuItem(title: "messages.action.${IMMessageAction.unsend.name}", userInfo: IMMessageAction.unsend));
    }
    if (state.forwardableMessageTypes.contains(message.type)) {
      // I18n
      items.add(MenuItem(title: "messages.action.${IMMessageAction.forward.name}", userInfo: IMMessageAction.forward));
    }
    if (state.reportableMessageTypes.contains(message.type) && !message.isMe) {
      // I18n
      items.add(MenuItem(title: "messages.action.${IMMessageAction.report.name}", userInfo: IMMessageAction.report));
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
        break;
      case IMMessageAction.edit:
        break;
      case IMMessageAction.report:
        break;
    }
  }
}
