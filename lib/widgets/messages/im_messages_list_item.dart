import 'package:flutter/material.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/widgets/components/im_circle_avatar_widget.dart';
import 'package:imkit/widgets/messages/items/im_message_item_audio.dart';
import 'package:imkit/widgets/messages/items/im_message_item_component.dart';
import 'package:imkit/widgets/messages/items/im_message_item_image.dart';
import 'package:imkit/widgets/messages/items/im_message_item_resend.dart';
import 'package:imkit/widgets/messages/items/im_message_item_status.dart';
import 'package:imkit/widgets/messages/items/im_message_item_system.dart';
import 'package:imkit/widgets/messages/items/im_message_item_text.dart';
import 'package:imkit/widgets/messages/items/im_message_item_video.dart';

class IMMessageListItem extends StatelessWidget {
  final IMRoom? room;
  final IMMessage message;

  const IMMessageListItem({Key? key, required this.room, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) => message.type == IMMessageType.system
      ? _bodyWidget(context: context)
      : message.isMe
          ? _outgoing(context)
          : _incoming(context);
}

extension on IMMessageListItem {
  Widget _incoming(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IMCircleAvatarWidget(
            text: message.sender?.nickname,
            url: message.sender?.avatarUrl,
            width: 35,
            height: 35,
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
                  _incomingBubble(context),
                  _statusWidget(),
                ],
              )
            ],
          ),
        ],
      );

  Widget _incomingBubble(BuildContext context) => Container(
      constraints: BoxConstraints(maxWidth: IMMessageItemComponent.getMaxCellWidth(context)),
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: IMKit.style.message.incoming.backgroundColor,
        borderRadius: BorderRadius.circular(IMKit.style.message.cornerRadius),
      ),
      child: _bodyWidget(context: context));

  Widget _outgoing(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: message.status == IMMessageStatus.undelivered ? CrossAxisAlignment.center : CrossAxisAlignment.end,
        children: [
          _statusWidget(),
          _outgoingBubble(context),
          _resendWidget(),
        ],
      );

  Widget _outgoingBubble(BuildContext context) => Container(
      constraints: BoxConstraints(maxWidth: IMMessageItemComponent.getMaxCellWidth(context)),
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: IMKit.style.message.outgoing.backgroundColor,
        borderRadius: BorderRadius.circular(IMKit.style.message.cornerRadius),
      ),
      child: _bodyWidget(context: context));
}

extension on IMMessageListItem {
  Widget _bodyWidget({required BuildContext context}) {
    switch (message.type) {
      case IMMessageType.text:
        return IMMessageItemText(message: message);

      case IMMessageType.image:
        return IMMessageItemImage(message: message);

      case IMMessageType.audio:
        return IMMessageItemAudio(message: message);

      case IMMessageType.video:
        return IMMessageItemVideo(message: message);

      // case IMMessageType.file:
      //   return;

      // case IMMessageType.location:
      //   return;

      // case IMMessageType.sticker:
      //   return;

      case IMMessageType.system:
        return IMMessageItemSystem(message: message);

      // case IMMessageType.template:
      //   return;

      // case IMMessageType.other:
      //   return;

      default:
        return IMMessageItemText(message: message);
    }
  }

  Widget _statusWidget() => IMMessageItemStatus(message: message);

  Widget _resendWidget() => Visibility(
        visible: message.status == IMMessageStatus.undelivered,
        child: IMMessageItemResend(message: message),
      );
}
