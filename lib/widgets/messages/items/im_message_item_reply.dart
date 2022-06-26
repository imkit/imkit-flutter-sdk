import 'package:flutter/material.dart';
import 'package:imkit/extensions/string_ext.dart';
import 'package:imkit/models/im_message.dart';
import 'package:imkit/sdk/imkit.dart';
import 'package:imkit/widgets/components/im_circle_avatar_widget.dart';
import 'package:imkit/widgets/components/im_rounded_image_widget.dart';

class IMMessageItemReply extends StatelessWidget {
  final IMMessage message;
  final double _padding = 8;
  const IMMessageItemReply({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: message.isMe ? IMKit.style.message.outgoing.lineColor : IMKit.style.message.incoming.lineColor,
              width: 0.5,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IMCircleAvatarWidget(
              text: message.responseObject?.sender?.nickname,
              url: message.responseObject?.sender?.avatarUrl,
              size: 24,
            ),
            Flexible(
              child: Container(
                margin: EdgeInsets.only(left: _padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: (message.responseObject?.sender?.nickname ?? "").isNotEmpty,
                      child: Text(
                        message.responseObject?.sender?.nickname ?? "",
                        style: message.isMe ? IMKit.style.message.outgoing.replyNameTextSytle : IMKit.style.message.incoming.replyNameTextSytle,
                      ),
                    ),
                    Visibility(
                      visible: (message.responseObject?.text ?? "").isNotEmpty,
                      child: Text((message.responseObject?.text ?? "").breakWord,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: message.isMe ? IMKit.style.message.outgoing.replyTextTextSytle : IMKit.style.message.incoming.replyTextTextSytle),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: (message.responseObject?.imageUrl ?? "").isNotEmpty,
              child: Padding(
                padding: EdgeInsets.only(left: _padding),
                child: IMRoundedAvatarWidget(url: message.responseObject?.imageUrl, size: 34),
              ),
            ),
          ],
        ),
      );
}
