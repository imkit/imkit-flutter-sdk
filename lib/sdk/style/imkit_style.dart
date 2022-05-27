import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:imkit/sdk/style/imkit_avatar_style.dart';
import 'package:imkit/sdk/style/imkit_message_input_bar_style.dart';
import 'package:imkit/sdk/style/imkit_message_item_style.dart';
import 'package:imkit/sdk/style/imkit_room_cell_style.dart';

class IMKitStyle {
  IMKitAvatarStyle avatar = IMKitAvatarStyle();
  IMKitRoomCellStyle room = IMKitRoomCellStyle();
  IMKitMessageItemStyle message = IMKitMessageItemStyle();
  ImkitMessageInputBarStyle inputBar = ImkitMessageInputBarStyle();

  Color primaryColor = const Color.fromRGBO(0, 160, 230, 1);
}
