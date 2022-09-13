// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ja locale. All the
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
  String get localeName => 'ja';

  static String m0(args) => "${args} が入力中 ...";

  static String m1(args) => "${args} が入力中 ...";

  static String m2(args) => "${args}選択しました";

  static String m3(args) => "${args} チャットルーム";

  static String m4(args) => "${args} 送られた";

  static String m5(args1, args2) => "${args1}は${args2}を招待します";

  static String m6(args) => "${args}はあなたをチャットに招待します";

  static String m7(args) => "${args}がチャットに参加します";

  static String m8(args1, args2) => "${args1}が${args2}を退会させました";

  static String m9(args) => "${args}はチャットを離れました";

  static String m10(args) => "検索 \"${args}\"";

  static String m11(args1, args2) => "${args1}送った${args2}";

  static String m12(args) => "${args}はメッセージを撤回しました";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "folder_choose_room":
            MessageLookupByLibrary.simpleMessage("チャットルームを選択してください"),
        "folder_create": MessageLookupByLibrary.simpleMessage("フォルダ追加"),
        "folder_edit": MessageLookupByLibrary.simpleMessage("編集フォルダ"),
        "folder_name": MessageLookupByLibrary.simpleMessage("フォルダ名"),
        "messages_action_cancel": MessageLookupByLibrary.simpleMessage("取り消し"),
        "messages_action_copy": MessageLookupByLibrary.simpleMessage("コピー"),
        "messages_action_delete": MessageLookupByLibrary.simpleMessage("削除"),
        "messages_action_edit": MessageLookupByLibrary.simpleMessage("編集"),
        "messages_action_forward": MessageLookupByLibrary.simpleMessage("転送"),
        "messages_action_reply": MessageLookupByLibrary.simpleMessage("リプライ"),
        "messages_action_report": MessageLookupByLibrary.simpleMessage("通報"),
        "messages_action_resend": MessageLookupByLibrary.simpleMessage("再送信"),
        "messages_action_shareLocation":
            MessageLookupByLibrary.simpleMessage("位置情報を共有する"),
        "messages_action_unsend": MessageLookupByLibrary.simpleMessage("送信取消"),
        "messages_edited": MessageLookupByLibrary.simpleMessage("編集済み"),
        "messages_fileCell_size": MessageLookupByLibrary.simpleMessage("サイズ"),
        "messages_linkPreview_tapOpen":
            MessageLookupByLibrary.simpleMessage("このリンクを開くには、ここをクリックしてください。"),
        "messages_location": MessageLookupByLibrary.simpleMessage("位置情報"),
        "messages_location_current":
            MessageLookupByLibrary.simpleMessage("現在位置"),
        "messages_multiple_typing": m0,
        "messages_outgoingCell_read":
            MessageLookupByLibrary.simpleMessage("既読"),
        "messages_several_typing":
            MessageLookupByLibrary.simpleMessage("複数人が入力してます"),
        "messages_single_typing": m1,
        "n_file": MessageLookupByLibrary.simpleMessage("ファイル"),
        "n_groupMembers": MessageLookupByLibrary.simpleMessage("グループメンバー"),
        "n_location": MessageLookupByLibrary.simpleMessage("位置情報"),
        "n_message": MessageLookupByLibrary.simpleMessage("メッセージ"),
        "n_noMembers": MessageLookupByLibrary.simpleMessage("メンバーがいません"),
        "n_photo": MessageLookupByLibrary.simpleMessage("写真"),
        "n_room_search_history": MessageLookupByLibrary.simpleMessage("最近の検索"),
        "n_sticker": MessageLookupByLibrary.simpleMessage("スティック"),
        "n_today": MessageLookupByLibrary.simpleMessage("本日"),
        "n_translation": MessageLookupByLibrary.simpleMessage("翻訳"),
        "n_unsupported_message":
            MessageLookupByLibrary.simpleMessage("メッセージ形式はまだサポートされていません"),
        "n_video": MessageLookupByLibrary.simpleMessage("ビデオ"),
        "n_voice_message": MessageLookupByLibrary.simpleMessage("音声メッセージ"),
        "n_yesterday": MessageLookupByLibrary.simpleMessage("昨日"),
        "p_p_saved": MessageLookupByLibrary.simpleMessage("保存しました"),
        "photo_select_count": m2,
        "preview_picture": MessageLookupByLibrary.simpleMessage("プレビュー"),
        "rooms_action_delete": MessageLookupByLibrary.simpleMessage("削除"),
        "rooms_action_edit": MessageLookupByLibrary.simpleMessage("編集"),
        "rooms_action_hide": MessageLookupByLibrary.simpleMessage("非表示"),
        "rooms_action_hide_alert":
            MessageLookupByLibrary.simpleMessage("チャットコンテンツは削除されません"),
        "rooms_action_mute": MessageLookupByLibrary.simpleMessage("無音"),
        "rooms_action_pin": MessageLookupByLibrary.simpleMessage("ピン"),
        "rooms_action_read": MessageLookupByLibrary.simpleMessage("読む"),
        "rooms_action_tag": MessageLookupByLibrary.simpleMessage("タグ"),
        "rooms_cell_emptyChat":
            MessageLookupByLibrary.simpleMessage("メンバーがいません"),
        "rooms_count": m3,
        "rooms_empty": MessageLookupByLibrary.simpleMessage("現在チャットルームはありません"),
        "rooms_leave":
            MessageLookupByLibrary.simpleMessage("あなたはチャットルームを離れました"),
        "rooms_title": MessageLookupByLibrary.simpleMessage("チャットルーム"),
        "s_You_sent_a": m4,
        "s_You_unsent_a_message":
            MessageLookupByLibrary.simpleMessage("メッセージの送信を取り消しました"),
        "s_You_were_mentioned":
            MessageLookupByLibrary.simpleMessage("You were mentioned."),
        "s_clear_all_of_your_recent_searches":
            MessageLookupByLibrary.simpleMessage("最近の検索履歴をすべて削除してもよろしいですか？"),
        "s_invited": m5,
        "s_invited_you_to_join_the_chat": m6,
        "s_joined_the_chat": m7,
        "s_kicked": m8,
        "s_left_the_chat": m9,
        "s_no_results_found":
            MessageLookupByLibrary.simpleMessage("一致するデータが見つかりません"),
        "s_no_search_records": MessageLookupByLibrary.simpleMessage("検索履歴なし"),
        "s_search_chat_history":
            MessageLookupByLibrary.simpleMessage("チャット履歴を検索"),
        "s_search_chat_room":
            MessageLookupByLibrary.simpleMessage("チャットルームを検索"),
        "s_search_keyword": m10,
        "s_sent_a": m11,
        "s_unsent_a_message": m12,
        "tag_add": MessageLookupByLibrary.simpleMessage("追加タグ"),
        "tag_choose_color": MessageLookupByLibrary.simpleMessage("色を選択してください"),
        "tag_color_message":
            MessageLookupByLibrary.simpleMessage("カラーコードを入力 (#02B13F)"),
        "tag_create": MessageLookupByLibrary.simpleMessage("追加タグ"),
        "tag_edit": MessageLookupByLibrary.simpleMessage("タグを編集します"),
        "tag_name_placeholder":
            MessageLookupByLibrary.simpleMessage("タグ名を入力してください"),
        "take_a_picture": MessageLookupByLibrary.simpleMessage("写真を撮る"),
        "v_cancel": MessageLookupByLibrary.simpleMessage("キャンセル"),
        "v_clear": MessageLookupByLibrary.simpleMessage("削除"),
        "v_clear_all": MessageLookupByLibrary.simpleMessage("すべて削除"),
        "v_confirm": MessageLookupByLibrary.simpleMessage("確認"),
        "v_create": MessageLookupByLibrary.simpleMessage("作成"),
        "v_join": MessageLookupByLibrary.simpleMessage("参加"),
        "v_leaveGroup": MessageLookupByLibrary.simpleMessage("グループを離れる"),
        "v_ok": MessageLookupByLibrary.simpleMessage("確認"),
        "v_open_google_map":
            MessageLookupByLibrary.simpleMessage("Google Mapを開く"),
        "v_open_map": MessageLookupByLibrary.simpleMessage("地図を開きます"),
        "v_save": MessageLookupByLibrary.simpleMessage("保存する"),
        "v_send": MessageLookupByLibrary.simpleMessage("転送"),
        "v_shareWith": MessageLookupByLibrary.simpleMessage("に送信することを選択します")
      };
}
