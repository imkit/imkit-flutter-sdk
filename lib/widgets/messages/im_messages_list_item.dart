import 'package:flutter/material.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/widgets/components/im_circle_avatar_widget.dart';
import 'package:imkit/widgets/messages/items/im_message_item_audio.dart';
import 'package:imkit/widgets/messages/items/im_message_item_component.dart';
import 'package:imkit/widgets/messages/items/im_message_item_image.dart';
import 'package:imkit/widgets/messages/items/im_message_item_menu.dart';
import 'package:imkit/widgets/messages/items/im_message_item_reply.dart';
import 'package:imkit/widgets/messages/items/im_message_item_resend.dart';
import 'package:imkit/widgets/messages/items/im_message_item_status.dart';
import 'package:imkit/widgets/messages/items/im_message_item_system.dart';
import 'package:imkit/widgets/messages/items/im_message_item_text.dart';
import 'package:imkit/widgets/messages/items/im_message_item_video.dart';
import 'package:popup_menu/popup_menu.dart';

class IMMessageListItem extends StatelessWidget {
  final IMRoom? room;
  final IMMessage message;

  final GlobalKey itemKey = GlobalKey();

  IMMessageListItem({Key? key, required this.room, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (message.type == IMMessageType.system) {
      return _bodyWidget(context: context);
    }
    return GestureDetector(
      onLongPress: () => _longPressMenu(context: context),
      child: message.isMe ? _outgoing(context) : _incoming(context),
    );
  }
}

extension on IMMessageListItem {
  Widget _incoming(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IMCircleAvatarWidget(
            text: message.sender?.nickname,
            url: message.sender?.avatarUrl,
            size: 35,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: (room?.type ?? IMRoomType.direct) == IMRoomType.group,
                child: Padding(
                  padding: const EdgeInsets.only(left: 6, bottom: 6),
                  child: Text(message.sender?.nickname ?? "", style: IMKit.style.message.incoming.nameTextSytle),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _bubble(context),
                  _statusWidget(),
                ],
              )
            ],
          ),
        ],
      );

  Widget _outgoing(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: message.status == IMMessageStatus.undelivered ? CrossAxisAlignment.center : CrossAxisAlignment.end,
        children: [
          _statusWidget(),
          _bubble(context),
          _resendWidget(),
        ],
      );
}

extension on IMMessageListItem {
  Widget _bubble(BuildContext context) => Container(
      constraints: BoxConstraints(maxWidth: IMMessageItemComponent.getMaxCellWidth(context)),
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: message.isMe ? IMKit.style.message.outgoing.backgroundColor : IMKit.style.message.incoming.backgroundColor,
        borderRadius: BorderRadius.circular(IMKit.style.message.cornerRadius),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_replyWidget(), _bodyWidget(context: context)]));

  Widget _bodyWidget({required BuildContext context}) {
    switch (message.type) {
      case IMMessageType.text:
        return IMMessageItemText(key: itemKey, message: message);

      case IMMessageType.image:
        return IMMessageItemImage(key: itemKey, message: message);

      case IMMessageType.audio:
        return IMMessageItemAudio(key: itemKey, message: message);

      case IMMessageType.video:
        return IMMessageItemVideo(key: itemKey, message: message);

      // case IMMessageType.file:
      //   return;

      // case IMMessageType.location:
      //   return;

      // case IMMessageType.sticker:
      //   return;

      case IMMessageType.system:
        return IMMessageItemSystem(key: itemKey, message: message);

      // case IMMessageType.template:
      //   return;

      // case IMMessageType.other:
      //   return;

      default:
        return IMMessageItemText(key: itemKey, message: message);
    }
  }

  Widget _statusWidget() => IMMessageItemStatus(message: message);

  Widget _replyWidget() => Visibility(
        visible: message.responseObject != null,
        child: IMMessageItemReply(message: message),
      );

  Widget _resendWidget() => Visibility(
        visible: message.status == IMMessageStatus.undelivered,
        child: IMMessageItemResend(message: message),
      );

  void _longPressMenu({required BuildContext context}) {
    final IMMessageItemMenu itemMenu = IMMessageItemMenu(message);
    final PopupMenu popupMenu = itemMenu.getPopupMenu(context);

    popupMenu.show(widgetKey: itemKey);
  }
}
