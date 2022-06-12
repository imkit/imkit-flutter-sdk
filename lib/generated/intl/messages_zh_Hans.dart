// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_Hans locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh_Hans';

  static String m0(args) => "${args} 正在输入中...";

  static String m1(args) => "${args} 正在输入中...";

  static String m2(args) => "已选${args}项";

  static String m3(args) => "${args}个聊天室";

  static String m4(args) => "${args}已传送";

  static String m5(args1, args2) => "${args1}邀请${args2}加入";

  static String m6(args) => "${args} 邀请您加入聊天";

  static String m7(args) => "${args}加入聊天";

  static String m8(args1, args2) => "${args1}将${args2}踢出";

  static String m9(args) => "${args}离开聊天";

  static String m10(args) => "搜寻 \"${args}\"";

  static String m11(args1, args2) => "${args1}向您传送了${args2}";

  static String m12(args) => "${args}已收回讯息";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "folder_choose_room":
            MessageLookupByLibrary.simpleMessage("选择要放进资料夹的聊天室"),
        "folder_create": MessageLookupByLibrary.simpleMessage("建立资料夹"),
        "folder_edit": MessageLookupByLibrary.simpleMessage("编辑资料夹"),
        "folder_name": MessageLookupByLibrary.simpleMessage("资料夹名称"),
        "messages_action_cancel": MessageLookupByLibrary.simpleMessage("取消"),
        "messages_action_copy": MessageLookupByLibrary.simpleMessage("复制"),
        "messages_action_delete": MessageLookupByLibrary.simpleMessage("删除"),
        "messages_action_edit": MessageLookupByLibrary.simpleMessage("编辑"),
        "messages_action_forward": MessageLookupByLibrary.simpleMessage("转传"),
        "messages_action_reply": MessageLookupByLibrary.simpleMessage("回覆"),
        "messages_action_report": MessageLookupByLibrary.simpleMessage("检举"),
        "messages_action_resend": MessageLookupByLibrary.simpleMessage("重传"),
        "messages_action_shareLocation":
            MessageLookupByLibrary.simpleMessage("分享位置"),
        "messages_action_unsend": MessageLookupByLibrary.simpleMessage("收回"),
        "messages_edited": MessageLookupByLibrary.simpleMessage("已编辑"),
        "messages_fileCell_size": MessageLookupByLibrary.simpleMessage("档案大小"),
        "messages_linkPreview_tapOpen":
            MessageLookupByLibrary.simpleMessage("点选此处以开启此连结。"),
        "messages_location": MessageLookupByLibrary.simpleMessage("位置"),
        "messages_location_current":
            MessageLookupByLibrary.simpleMessage("目前位置"),
        "messages_multiple_typing": m0,
        "messages_outgoingCell_read":
            MessageLookupByLibrary.simpleMessage("已读"),
        "messages_several_typing":
            MessageLookupByLibrary.simpleMessage("多人正在输入中..."),
        "messages_single_typing": m1,
        "n_file": MessageLookupByLibrary.simpleMessage("档案"),
        "n_groupMembers": MessageLookupByLibrary.simpleMessage("群组成员"),
        "n_location": MessageLookupByLibrary.simpleMessage("位置"),
        "n_message": MessageLookupByLibrary.simpleMessage("讯息"),
        "n_noMembers": MessageLookupByLibrary.simpleMessage("没有其他成员"),
        "n_photo": MessageLookupByLibrary.simpleMessage("照片"),
        "n_room_search_history": MessageLookupByLibrary.simpleMessage("最近搜寻"),
        "n_sticker": MessageLookupByLibrary.simpleMessage("贴图"),
        "n_today": MessageLookupByLibrary.simpleMessage("今天"),
        "n_translation": MessageLookupByLibrary.simpleMessage("翻译"),
        "n_unsupported_message":
            MessageLookupByLibrary.simpleMessage("尚未支援的讯息格式"),
        "n_video": MessageLookupByLibrary.simpleMessage("影片"),
        "n_voice_message": MessageLookupByLibrary.simpleMessage("语音讯息"),
        "n_yesterday": MessageLookupByLibrary.simpleMessage("昨天"),
        "p_p_saved": MessageLookupByLibrary.simpleMessage("已储存"),
        "photo_select_count": m2,
        "rooms_action_delete": MessageLookupByLibrary.simpleMessage("删除"),
        "rooms_action_edit": MessageLookupByLibrary.simpleMessage("编辑"),
        "rooms_action_hide": MessageLookupByLibrary.simpleMessage("隐藏"),
        "rooms_action_hide_alert":
            MessageLookupByLibrary.simpleMessage("聊天内容将不会被删除。"),
        "rooms_action_mute": MessageLookupByLibrary.simpleMessage("静音"),
        "rooms_action_pin": MessageLookupByLibrary.simpleMessage("置顶"),
        "rooms_action_read": MessageLookupByLibrary.simpleMessage("已读"),
        "rooms_action_tag": MessageLookupByLibrary.simpleMessage("标签"),
        "rooms_cell_emptyChat": MessageLookupByLibrary.simpleMessage("没有成员"),
        "rooms_count": m3,
        "rooms_leave": MessageLookupByLibrary.simpleMessage("你已退出群组"),
        "rooms_title": MessageLookupByLibrary.simpleMessage("聊天室"),
        "s_You_sent_a": m4,
        "s_You_unsent_a_message":
            MessageLookupByLibrary.simpleMessage("您已收回讯息"),
        "s_You_were_mentioned": MessageLookupByLibrary.simpleMessage("您已被标注。"),
        "s_clear_all_of_your_recent_searches":
            MessageLookupByLibrary.simpleMessage("确定删除所有最近的搜寻纪录？"),
        "s_invited": m5,
        "s_invited_you_to_join_the_chat": m6,
        "s_joined_the_chat": m7,
        "s_kicked": m8,
        "s_left_the_chat": m9,
        "s_no_results_found": MessageLookupByLibrary.simpleMessage("找不到符合的资料"),
        "s_no_search_records": MessageLookupByLibrary.simpleMessage("尚无搜寻纪录"),
        "s_search_chat_history": MessageLookupByLibrary.simpleMessage("搜寻聊天纪录"),
        "s_search_chat_room": MessageLookupByLibrary.simpleMessage("搜寻聊天室"),
        "s_search_keyword": m10,
        "s_sent_a": m11,
        "s_unsent_a_message": m12,
        "tag_add": MessageLookupByLibrary.simpleMessage("新增标签"),
        "tag_choose_color": MessageLookupByLibrary.simpleMessage("选择颜色"),
        "tag_color_message":
            MessageLookupByLibrary.simpleMessage("输入自订色彩例如 #02B13F"),
        "tag_create": MessageLookupByLibrary.simpleMessage("建立标签"),
        "tag_edit": MessageLookupByLibrary.simpleMessage("编辑标签"),
        "tag_name_placeholder": MessageLookupByLibrary.simpleMessage("输入标签名称"),
        "v_cancel": MessageLookupByLibrary.simpleMessage("取消"),
        "v_clear": MessageLookupByLibrary.simpleMessage("清除"),
        "v_clear_all": MessageLookupByLibrary.simpleMessage("全部删除"),
        "v_confirm": MessageLookupByLibrary.simpleMessage("确定"),
        "v_create": MessageLookupByLibrary.simpleMessage("建立"),
        "v_join": MessageLookupByLibrary.simpleMessage("加入"),
        "v_leaveGroup": MessageLookupByLibrary.simpleMessage("退出群组"),
        "v_ok": MessageLookupByLibrary.simpleMessage("确定"),
        "v_open_google_map":
            MessageLookupByLibrary.simpleMessage("打开 Google 地图"),
        "v_open_map": MessageLookupByLibrary.simpleMessage("打开地图"),
        "v_save": MessageLookupByLibrary.simpleMessage("储存"),
        "v_send": MessageLookupByLibrary.simpleMessage("传送"),
        "v_shareWith": MessageLookupByLibrary.simpleMessage("选择传送对象")
      };
}
