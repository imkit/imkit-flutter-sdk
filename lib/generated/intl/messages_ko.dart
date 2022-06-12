// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ko locale. All the
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
  String get localeName => 'ko';

  static String m0(args) => "${args} 이 입력 중입니다....";

  static String m1(args) => "${args} 가 입력 중입니다...";

  static String m2(args) => "${args} 선정";

  static String m3(args) => "${args} 대화방";

  static String m4(args) => "${args} 보냄";

  static String m5(args1, args2) => "${args1}는${args2}을 채팅에 초대합니다";

  static String m6(args) => "${args} 가 채팅에 초대합니다";

  static String m7(args) => "${args} 채팅방에 참여";

  static String m8(args1, args2) => "${args1}는${args2}을 그룹에서 쫓아 냈습니다";

  static String m9(args) => "${args} 채팅 나가기";

  static String m10(args) => "검색 \"${args}\"";

  static String m11(args1, args2) => "${args1} 가 ${args2} 를 보냈습니다";

  static String m12(args) => "${args}는 뉴스를 철회했습니다";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "folder_choose_room":
            MessageLookupByLibrary.simpleMessage("이 폴더에 추가할 채팅방을 선택하세요"),
        "folder_create": MessageLookupByLibrary.simpleMessage("폴더 만들기"),
        "folder_edit": MessageLookupByLibrary.simpleMessage("편집 폴더"),
        "folder_name": MessageLookupByLibrary.simpleMessage("폴더 이름"),
        "messages_action_cancel": MessageLookupByLibrary.simpleMessage("취소"),
        "messages_action_copy": MessageLookupByLibrary.simpleMessage("복사"),
        "messages_action_delete": MessageLookupByLibrary.simpleMessage("삭제"),
        "messages_action_edit": MessageLookupByLibrary.simpleMessage("편집"),
        "messages_action_forward": MessageLookupByLibrary.simpleMessage("앞으로"),
        "messages_action_reply": MessageLookupByLibrary.simpleMessage("답장"),
        "messages_action_report": MessageLookupByLibrary.simpleMessage("신고"),
        "messages_action_resend": MessageLookupByLibrary.simpleMessage("재전송"),
        "messages_action_shareLocation":
            MessageLookupByLibrary.simpleMessage("위치 공유"),
        "messages_action_unsend": MessageLookupByLibrary.simpleMessage("안읽은"),
        "messages_edited": MessageLookupByLibrary.simpleMessage("편집"),
        "messages_fileCell_size": MessageLookupByLibrary.simpleMessage("파일 크기"),
        "messages_linkPreview_tapOpen":
            MessageLookupByLibrary.simpleMessage("이 링크를 열려면 여기를 클릭하십시오"),
        "messages_location": MessageLookupByLibrary.simpleMessage("위치"),
        "messages_location_current":
            MessageLookupByLibrary.simpleMessage("현재 위치"),
        "messages_multiple_typing": m0,
        "messages_outgoingCell_read":
            MessageLookupByLibrary.simpleMessage("이미 읽음"),
        "messages_several_typing":
            MessageLookupByLibrary.simpleMessage("여러 사람이 입력하고 있습니다..."),
        "messages_single_typing": m1,
        "n_file": MessageLookupByLibrary.simpleMessage("파일"),
        "n_groupMembers": MessageLookupByLibrary.simpleMessage("그룹 구성원"),
        "n_location": MessageLookupByLibrary.simpleMessage("위치"),
        "n_message": MessageLookupByLibrary.simpleMessage("메시지"),
        "n_noMembers": MessageLookupByLibrary.simpleMessage("다른 회원 없음"),
        "n_photo": MessageLookupByLibrary.simpleMessage("사진"),
        "n_room_search_history": MessageLookupByLibrary.simpleMessage("최근 검색"),
        "n_sticker": MessageLookupByLibrary.simpleMessage("이모티콘"),
        "n_today": MessageLookupByLibrary.simpleMessage("요즘"),
        "n_translation": MessageLookupByLibrary.simpleMessage("번역"),
        "n_unsupported_message":
            MessageLookupByLibrary.simpleMessage("메시지 형식은 아직 지원되지 않습니다."),
        "n_video": MessageLookupByLibrary.simpleMessage("영상"),
        "n_voice_message": MessageLookupByLibrary.simpleMessage("녹음 메시지"),
        "n_yesterday": MessageLookupByLibrary.simpleMessage("어제"),
        "p_p_saved": MessageLookupByLibrary.simpleMessage("저장 됨"),
        "photo_select_count": m2,
        "rooms_action_delete": MessageLookupByLibrary.simpleMessage("삭제"),
        "rooms_action_edit": MessageLookupByLibrary.simpleMessage("편집하다"),
        "rooms_action_hide": MessageLookupByLibrary.simpleMessage("숨는 장소"),
        "rooms_action_hide_alert":
            MessageLookupByLibrary.simpleMessage("채팅 내용은 삭제되지 않습니다"),
        "rooms_action_mute": MessageLookupByLibrary.simpleMessage("무음"),
        "rooms_action_pin": MessageLookupByLibrary.simpleMessage("핀"),
        "rooms_action_read": MessageLookupByLibrary.simpleMessage("읽다"),
        "rooms_action_tag": MessageLookupByLibrary.simpleMessage("태그"),
        "rooms_cell_emptyChat": MessageLookupByLibrary.simpleMessage("회원 없음"),
        "rooms_count": m3,
        "rooms_leave": MessageLookupByLibrary.simpleMessage("당신은 대화방을 떠났습니다"),
        "rooms_title": MessageLookupByLibrary.simpleMessage("대화방"),
        "s_You_sent_a": m4,
        "s_You_unsent_a_message":
            MessageLookupByLibrary.simpleMessage("메시지를 철회했습니다."),
        "s_You_were_mentioned":
            MessageLookupByLibrary.simpleMessage("You were mentioned."),
        "s_clear_all_of_your_recent_searches":
            MessageLookupByLibrary.simpleMessage("최근 검색 기록을 모두 삭제 하시겠습니까?"),
        "s_invited": m5,
        "s_invited_you_to_join_the_chat": m6,
        "s_joined_the_chat": m7,
        "s_kicked": m8,
        "s_left_the_chat": m9,
        "s_no_results_found":
            MessageLookupByLibrary.simpleMessage("일치하는 데이터가 없습니다"),
        "s_no_search_records":
            MessageLookupByLibrary.simpleMessage("검색 기록이 없습니다"),
        "s_search_chat_history":
            MessageLookupByLibrary.simpleMessage("채팅 기록 검색"),
        "s_search_chat_room": MessageLookupByLibrary.simpleMessage("대화방 검색"),
        "s_search_keyword": m10,
        "s_sent_a": m11,
        "s_unsent_a_message": m12,
        "tag_add": MessageLookupByLibrary.simpleMessage("태그 추가"),
        "tag_choose_color": MessageLookupByLibrary.simpleMessage("색상을 선택하십시오"),
        "tag_color_message":
            MessageLookupByLibrary.simpleMessage("색상 코드 입력 (#02B13F)"),
        "tag_create": MessageLookupByLibrary.simpleMessage("태그 만들기"),
        "tag_edit": MessageLookupByLibrary.simpleMessage("편집 태그"),
        "tag_name_placeholder":
            MessageLookupByLibrary.simpleMessage("태그 이름을 입력하십시오"),
        "v_cancel": MessageLookupByLibrary.simpleMessage("취소"),
        "v_clear": MessageLookupByLibrary.simpleMessage("지우다"),
        "v_clear_all": MessageLookupByLibrary.simpleMessage("모두 삭제"),
        "v_confirm": MessageLookupByLibrary.simpleMessage("확인"),
        "v_create": MessageLookupByLibrary.simpleMessage("창조하다"),
        "v_join": MessageLookupByLibrary.simpleMessage("붙다"),
        "v_leaveGroup": MessageLookupByLibrary.simpleMessage("그룹을 떠나다"),
        "v_ok": MessageLookupByLibrary.simpleMessage("확인"),
        "v_open_google_map":
            MessageLookupByLibrary.simpleMessage("Google지도를 엽니 다"),
        "v_open_map": MessageLookupByLibrary.simpleMessage("지도를 엽니 다"),
        "v_save": MessageLookupByLibrary.simpleMessage("구하다"),
        "v_send": MessageLookupByLibrary.simpleMessage("전송"),
        "v_shareWith": MessageLookupByLibrary.simpleMessage("보내도록 선택")
      };
}
