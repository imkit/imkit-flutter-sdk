import 'package:flutter/material.dart';
import 'package:imkit/extensions/color_ext.dart';
import 'package:imkit/extensions/string_ext.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/extensions/date_ext.dart';
import 'package:imkit/widgets/components/im_room_avatar_widget.dart';
import 'package:imkit/widgets/messages/im_messages_view.dart';

class IMRoomsListItem extends StatelessWidget {
  final IMRoom room;
  const IMRoomsListItem({Key? key, required this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => IMMessagesView(roomId: room.id, room: room))),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // Avatar
              IMRoomAvatarWidget(
                room: room,
                width: 50,
                height: 50,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Title
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    room.title.breakWord,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: IMKit.style.room.title,
                                  ),
                                ),
                                Visibility(
                                  visible: room.isMuted,
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 4),
                                    child: Icon(Icons.volume_off, color: Color(0xFFD3D5D7), size: 16),
                                  ),
                                ),
                              ],
                            ),

                            // Subtitle
                            Visibility(
                              visible: room.subtitle.isNotEmpty,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  room.subtitle.breakWord,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: IMKit.style.room.subtitle,
                                ),
                              ),
                            ),
                            // Mentioned
                            Visibility(
                              visible: room.isMentioned,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  // I18n
                                  "s.You were mentioned",
                                  style: IMKit.style.room.mentioned,
                                ),
                              ),
                            ),

                            // Tags
                            Visibility(
                              visible: room.tags.isNotEmpty,
                              child: Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: room.tags
                                        .map((element) => Container(
                                              height: 24,
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.symmetric(horizontal: 3),
                                              margin: const EdgeInsets.only(right: 3),
                                              decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                color: HexColor.fromHex(element.hexColorCode),
                                              ),
                                              child: Text(element.name, style: const TextStyle(fontSize: 12, color: Colors.white)),
                                            ))
                                        .toList(),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Datetime
                            Text(room.updatedAt?.toHumanString ?? "", style: IMKit.style.room.time),

                            // Badge
                            Container(
                              height: 24,
                              constraints: const BoxConstraints(minWidth: 24),
                              margin: const EdgeInsets.only(top: 4),
                              child: Visibility(
                                visible: room.numberOfUnreadMessagesCount.isNotEmpty,
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                                    color: IMKit.style.room.numberOfUnreadBackgroundColor,
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                  child: Text(
                                    room.numberOfUnreadMessagesCount,
                                    style: IMKit.style.room.numberOfUnread,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
