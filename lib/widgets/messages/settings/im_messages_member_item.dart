import 'package:flutter/material.dart';
import 'package:imkit/extensions/string_ext.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/widgets/components/im_circle_avatar_widget.dart';

class IMMessagesMemberItem extends StatelessWidget {
  final IMUser user;
  const IMMessagesMemberItem({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            // Avatar
            IMCircleAvatarWidget(
              text: user.nickname,
              url: user.avatarUrl,
              size: 50,
            ),

            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Title
                    Text(
                      user.nickname.breakWord,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: IMKit.style.room.title,
                    ),

                    // Subtitle
                    Visibility(
                      visible: (user.desc ?? "").isNotEmpty,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          (user.desc ?? "").breakWord,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: IMKit.style.room.subtitle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
