// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_Hant locale. All the
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
  String get localeName => 'zh_Hant';

  static String m0(args) => "${args} 正在輸入中...";

  static String m1(args) => "${args} 正在輸入中...";

  static String m2(args) => "已選${args}項";

  static String m3(args) => "${args}個聊天室";

  static String m4(args) => "${args}已傳送";

  static String m5(args1, args2) => "${args1}邀請${args2}加入";

  static String m6(args) => "${args} 邀請您加入聊天";

  static String m7(args) => "${args}加入聊天";

  static String m8(args1, args2) => "${args1}將${args2}踢出";

  static String m9(args) => "${args}離開聊天";

  static String m10(args) => "搜尋 \"${args}\"";

  static String m11(args1, args2) => "${args1}向您傳送了${args2}";

  static String m12(args) => "${args}已收回訊息";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "folder_choose_room":
            MessageLookupByLibrary.simpleMessage("選擇要放進資料夾的聊天室"),
        "folder_create": MessageLookupByLibrary.simpleMessage("建立資料夾"),
        "folder_edit": MessageLookupByLibrary.simpleMessage("編輯資料夾"),
        "folder_name": MessageLookupByLibrary.simpleMessage("資料夾名稱"),
        "messages_action_cancel": MessageLookupByLibrary.simpleMessage("取消"),
        "messages_action_copy": MessageLookupByLibrary.simpleMessage("複製"),
        "messages_action_delete": MessageLookupByLibrary.simpleMessage("刪除"),
        "messages_action_edit": MessageLookupByLibrary.simpleMessage("編輯"),
        "messages_action_forward": MessageLookupByLibrary.simpleMessage("轉傳"),
        "messages_action_reply": MessageLookupByLibrary.simpleMessage("回覆"),
        "messages_action_report": MessageLookupByLibrary.simpleMessage("檢舉"),
        "messages_action_resend": MessageLookupByLibrary.simpleMessage("重傳"),
        "messages_action_shareLocation":
            MessageLookupByLibrary.simpleMessage("分享位置"),
        "messages_action_unsend": MessageLookupByLibrary.simpleMessage("收回"),
        "messages_edited": MessageLookupByLibrary.simpleMessage("已編輯"),
        "messages_fileCell_size": MessageLookupByLibrary.simpleMessage("檔案大小"),
        "messages_linkPreview_tapOpen":
            MessageLookupByLibrary.simpleMessage("點選此處以開啟此連結。"),
        "messages_location": MessageLookupByLibrary.simpleMessage("位置"),
        "messages_location_current":
            MessageLookupByLibrary.simpleMessage("目前位置"),
        "messages_multiple_typing": m0,
        "messages_outgoingCell_read":
            MessageLookupByLibrary.simpleMessage("已讀"),
        "messages_several_typing":
            MessageLookupByLibrary.simpleMessage("多人正在輸入中..."),
        "messages_single_typing": m1,
        "n_file": MessageLookupByLibrary.simpleMessage("檔案"),
        "n_groupMembers": MessageLookupByLibrary.simpleMessage("群組成員"),
        "n_location": MessageLookupByLibrary.simpleMessage("位置"),
        "n_message": MessageLookupByLibrary.simpleMessage("訊息"),
        "n_noMembers": MessageLookupByLibrary.simpleMessage("沒有其他成員"),
        "n_photo": MessageLookupByLibrary.simpleMessage("照片"),
        "n_room_search_history": MessageLookupByLibrary.simpleMessage("最近搜尋"),
        "n_sticker": MessageLookupByLibrary.simpleMessage("貼圖"),
        "n_today": MessageLookupByLibrary.simpleMessage("今天"),
        "n_translation": MessageLookupByLibrary.simpleMessage("翻譯"),
        "n_unsupported_message":
            MessageLookupByLibrary.simpleMessage("尚未支援的訊息格式"),
        "n_video": MessageLookupByLibrary.simpleMessage("影片"),
        "n_voice_message": MessageLookupByLibrary.simpleMessage("語音訊息"),
        "n_yesterday": MessageLookupByLibrary.simpleMessage("昨天"),
        "p_p_saved": MessageLookupByLibrary.simpleMessage("已儲存"),
        "photo_select_count": m2,
        "preview_picture": MessageLookupByLibrary.simpleMessage("預覽照片"),
        "rooms_action_delete": MessageLookupByLibrary.simpleMessage("刪除"),
        "rooms_action_edit": MessageLookupByLibrary.simpleMessage("編輯"),
        "rooms_action_hide": MessageLookupByLibrary.simpleMessage("隱藏"),
        "rooms_action_hide_alert":
            MessageLookupByLibrary.simpleMessage("聊天內容將不會被刪除。"),
        "rooms_action_mute": MessageLookupByLibrary.simpleMessage("靜音"),
        "rooms_action_pin": MessageLookupByLibrary.simpleMessage("置頂"),
        "rooms_action_read": MessageLookupByLibrary.simpleMessage("已讀"),
        "rooms_action_tag": MessageLookupByLibrary.simpleMessage("標籤"),
        "rooms_cell_emptyChat": MessageLookupByLibrary.simpleMessage("沒有成員"),
        "rooms_count": m3,
        "rooms_empty": MessageLookupByLibrary.simpleMessage("目前沒有聊天室"),
        "rooms_leave": MessageLookupByLibrary.simpleMessage("你已退出群組"),
        "rooms_title": MessageLookupByLibrary.simpleMessage("聊天室"),
        "s_You_sent_a": m4,
        "s_You_unsent_a_message":
            MessageLookupByLibrary.simpleMessage("您已收回訊息"),
        "s_You_were_mentioned": MessageLookupByLibrary.simpleMessage("您已被標註。"),
        "s_clear_all_of_your_recent_searches":
            MessageLookupByLibrary.simpleMessage("確定刪除所有最近的搜尋紀錄？"),
        "s_invited": m5,
        "s_invited_you_to_join_the_chat": m6,
        "s_joined_the_chat": m7,
        "s_kicked": m8,
        "s_left_the_chat": m9,
        "s_no_results_found": MessageLookupByLibrary.simpleMessage("找不到符合的資料"),
        "s_no_search_records": MessageLookupByLibrary.simpleMessage("尚無搜尋紀錄"),
        "s_search_chat_history": MessageLookupByLibrary.simpleMessage("搜尋聊天紀錄"),
        "s_search_chat_room": MessageLookupByLibrary.simpleMessage("搜尋聊天室"),
        "s_search_keyword": m10,
        "s_sent_a": m11,
        "s_unsent_a_message": m12,
        "tag_add": MessageLookupByLibrary.simpleMessage("新增標籤"),
        "tag_choose_color": MessageLookupByLibrary.simpleMessage("選擇顏色"),
        "tag_color_message":
            MessageLookupByLibrary.simpleMessage("輸入自訂色彩例如 #02B13F"),
        "tag_create": MessageLookupByLibrary.simpleMessage("建立標籤"),
        "tag_edit": MessageLookupByLibrary.simpleMessage("編輯標籤"),
        "tag_name_placeholder": MessageLookupByLibrary.simpleMessage("輸入標籤名稱"),
        "take_a_picture": MessageLookupByLibrary.simpleMessage("拍照"),
        "v_cancel": MessageLookupByLibrary.simpleMessage("取消"),
        "v_clear": MessageLookupByLibrary.simpleMessage("清除"),
        "v_clear_all": MessageLookupByLibrary.simpleMessage("全部刪除"),
        "v_confirm": MessageLookupByLibrary.simpleMessage("確定"),
        "v_create": MessageLookupByLibrary.simpleMessage("建立"),
        "v_join": MessageLookupByLibrary.simpleMessage("加入"),
        "v_leaveGroup": MessageLookupByLibrary.simpleMessage("退出群組"),
        "v_ok": MessageLookupByLibrary.simpleMessage("確定"),
        "v_open_google_map":
            MessageLookupByLibrary.simpleMessage("打開 Google 地圖"),
        "v_open_map": MessageLookupByLibrary.simpleMessage("打開地圖"),
        "v_save": MessageLookupByLibrary.simpleMessage("儲存"),
        "v_send": MessageLookupByLibrary.simpleMessage("傳送"),
        "v_shareWith": MessageLookupByLibrary.simpleMessage("選擇傳送對象")
      };
}
