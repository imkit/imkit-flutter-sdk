import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:imkit/models/im_room.dart';
import 'package:imkit/models/im_user.dart';
import 'package:imkit/sdk/imkit.dart';
import 'package:imkit/widgets/components/im_circle_avatar_widget.dart';

class IMRoomAvatarWidget extends StatelessWidget {
  const IMRoomAvatarWidget({
    Key? key,
    required this.room,
    this.fit = BoxFit.cover,
    this.width = double.infinity,
    this.height = double.infinity,
  }) : super(key: key);

  final IMRoom room;
  final BoxFit fit;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        decoration: BoxDecoration(shape: BoxShape.circle, color: IMKit.style.avatar.backgroundColor),
        clipBehavior: Clip.hardEdge,
        child: _getChild(),
      );

  Widget? _getChild() {
    if ((room.coverUrl ?? "").isNotEmpty) {
      return _circleAvatar(url: room.coverUrl, text: room.name, onError: _getChildByRoomType);
    }
    return _getChildByRoomType();
  }

  Widget? _getChildByRoomType() {
    final users = room.members.where((element) => (element.avatarUrl ?? "").isNotEmpty || element.nickname.isNotEmpty).sorted((lhs, rhs) {
      if (lhs.avatarUrl != null && rhs.avatarUrl == null) {
        return 1;
      } else if (lhs.nickname.isNotEmpty && rhs.nickname.isEmpty) {
        return 1;
      }
      return 0;
    });

    switch (room.type) {
      case IMRoomType.direct:
        return _fromRoomDirect(users);

      case IMRoomType.group:
        return _fromRoomGroup(users);
    }
  }

  Widget? _fromRoomDirect(List<IMUser> users) {
    final usersWithoutMe = users.where((element) => element.id != IMKit.uid && element.nickname.isNotEmpty);
    if (usersWithoutMe.length == 1) {
      return _userCircleAvatar(user: usersWithoutMe.first);
    } else {
      return _fromRoomGroup(users);
    }
  }

  Widget? _fromRoomGroup(List<IMUser> users) {
    final total = min(4, users.length);
    if (total <= 0) {
      return null;
    }

    switch (users.length) {
      case 1:
        return _userCircleAvatar(user: users.first);

      case 2:
        return Row(
          children: [
            _userCircleAvatar(user: users.first, w: width / 2),
            _userCircleAvatar(user: users.last, w: width / 2),
          ],
        );

      case 3:
        return Row(
          children: [
            _userCircleAvatar(user: users[0], w: width / 2),
            Column(
              children: [
                _userCircleAvatar(user: users[1], w: width / 2, h: height / 2),
                _userCircleAvatar(user: users[2], w: width / 2, h: height / 2),
              ],
            )
          ],
        );

      default:
        return Row(
          children: [
            Column(
              children: [
                _userCircleAvatar(user: users[0], w: width / 2, h: height / 2),
                _userCircleAvatar(user: users[1], w: width / 2, h: height / 2),
              ],
            ),
            Column(
              children: [
                _userCircleAvatar(user: users[2], w: width / 2, h: height / 2),
                _userCircleAvatar(user: users[3], w: width / 2, h: height / 2),
              ],
            )
          ],
        );
    }
  }

  Widget _userCircleAvatar({required IMUser user, double? w, double? h}) => _circleAvatar(
        url: user.avatarUrl,
        text: user.nickname,
        w: w,
        h: h,
      );

  Widget _circleAvatar({String? url, String? text, double? w, double? h, Function? onError}) => IMCircleAvatarWidget(
        url: url,
        text: text,
        width: w ?? width,
        height: h ?? height,
        fit: fit,
        onError: onError,
      );
}
