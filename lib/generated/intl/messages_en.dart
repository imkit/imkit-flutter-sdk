// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(args) => "${args} are typing...";

  static String m1(args) => "${args} is typing...";

  static String m2(args) => "${args} selected";

  static String m3(args) => "${args} chatrooms";

  static String m4(args) => "You sent a ${args}";

  static String m5(args1, args2) => "${args1} invited ${args2}";

  static String m6(args) => "${args} invited you to join the chat.";

  static String m7(args) => "${args} joined the chat";

  static String m8(args1, args2) => "${args1} kicked ${args2}";

  static String m9(args) => "${args} left the chat";

  static String m10(args) => "Searching \"${args}\"";

  static String m11(args1, args2) => "${args1} sent a ${args2}";

  static String m12(args) => "${args} unsent a message";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "folder_choose_room": MessageLookupByLibrary.simpleMessage(
            "Choose the chatrooms to add in this folder"),
        "folder_create": MessageLookupByLibrary.simpleMessage("Create folder"),
        "folder_edit": MessageLookupByLibrary.simpleMessage("Edit folder"),
        "folder_name": MessageLookupByLibrary.simpleMessage("Folder name"),
        "messages_action_cancel":
            MessageLookupByLibrary.simpleMessage("Cancel"),
        "messages_action_copy": MessageLookupByLibrary.simpleMessage("Copy"),
        "messages_action_delete":
            MessageLookupByLibrary.simpleMessage("Delete"),
        "messages_action_edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "messages_action_forward":
            MessageLookupByLibrary.simpleMessage("Forward"),
        "messages_action_reply": MessageLookupByLibrary.simpleMessage("Reply"),
        "messages_action_report":
            MessageLookupByLibrary.simpleMessage("Report"),
        "messages_action_resend":
            MessageLookupByLibrary.simpleMessage("Resend"),
        "messages_action_shareLocation":
            MessageLookupByLibrary.simpleMessage("Share location"),
        "messages_action_unsend":
            MessageLookupByLibrary.simpleMessage("Unsend"),
        "messages_edited": MessageLookupByLibrary.simpleMessage("Edited"),
        "messages_fileCell_size": MessageLookupByLibrary.simpleMessage("Size"),
        "messages_linkPreview_tapOpen":
            MessageLookupByLibrary.simpleMessage("Tap here to open the link."),
        "messages_location": MessageLookupByLibrary.simpleMessage("Location"),
        "messages_location_current":
            MessageLookupByLibrary.simpleMessage("Current location"),
        "messages_multiple_typing": m0,
        "messages_outgoingCell_read":
            MessageLookupByLibrary.simpleMessage("Read"),
        "messages_several_typing": MessageLookupByLibrary.simpleMessage(
            "Several people are typing..."),
        "messages_single_typing": m1,
        "n_file": MessageLookupByLibrary.simpleMessage("File"),
        "n_groupMembers": MessageLookupByLibrary.simpleMessage("Group members"),
        "n_location": MessageLookupByLibrary.simpleMessage("Location"),
        "n_message": MessageLookupByLibrary.simpleMessage("message"),
        "n_noMembers": MessageLookupByLibrary.simpleMessage("No members"),
        "n_photo": MessageLookupByLibrary.simpleMessage("photo"),
        "n_room_search_history":
            MessageLookupByLibrary.simpleMessage("Search history"),
        "n_sticker": MessageLookupByLibrary.simpleMessage("sticker"),
        "n_today": MessageLookupByLibrary.simpleMessage("Today"),
        "n_translation": MessageLookupByLibrary.simpleMessage("Translation"),
        "n_unsupported_message":
            MessageLookupByLibrary.simpleMessage("Unsupported Message"),
        "n_video": MessageLookupByLibrary.simpleMessage("video"),
        "n_voice_message":
            MessageLookupByLibrary.simpleMessage("voice message"),
        "n_yesterday": MessageLookupByLibrary.simpleMessage("Yesterday"),
        "p_p_saved": MessageLookupByLibrary.simpleMessage("Saved"),
        "photo_select_count": m2,
        "rooms_action_delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "rooms_action_edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "rooms_action_hide": MessageLookupByLibrary.simpleMessage("Hide"),
        "rooms_action_hide_alert": MessageLookupByLibrary.simpleMessage(
            "Chat messages wouldn\'t be deleted"),
        "rooms_action_mute": MessageLookupByLibrary.simpleMessage("Mute"),
        "rooms_action_pin": MessageLookupByLibrary.simpleMessage("Pin"),
        "rooms_action_read": MessageLookupByLibrary.simpleMessage("Read"),
        "rooms_action_tag": MessageLookupByLibrary.simpleMessage("Tag"),
        "rooms_cell_emptyChat":
            MessageLookupByLibrary.simpleMessage("Empty chat"),
        "rooms_count": m3,
        "rooms_empty": MessageLookupByLibrary.simpleMessage(
            "There are currently no chat rooms"),
        "rooms_leave":
            MessageLookupByLibrary.simpleMessage("You have left the chatroom"),
        "rooms_title": MessageLookupByLibrary.simpleMessage("Chatroom"),
        "s_You_sent_a": m4,
        "s_You_unsent_a_message":
            MessageLookupByLibrary.simpleMessage("You unsent a message"),
        "s_You_were_mentioned":
            MessageLookupByLibrary.simpleMessage("You were mentioned."),
        "s_clear_all_of_your_recent_searches":
            MessageLookupByLibrary.simpleMessage(
                "Clear all of your recent searches?"),
        "s_invited": m5,
        "s_invited_you_to_join_the_chat": m6,
        "s_joined_the_chat": m7,
        "s_kicked": m8,
        "s_left_the_chat": m9,
        "s_no_results_found":
            MessageLookupByLibrary.simpleMessage("No results found."),
        "s_no_search_records":
            MessageLookupByLibrary.simpleMessage("No search records"),
        "s_search_chat_history":
            MessageLookupByLibrary.simpleMessage("Search..."),
        "s_search_chat_room": MessageLookupByLibrary.simpleMessage("Search..."),
        "s_search_keyword": m10,
        "s_sent_a": m11,
        "s_unsent_a_message": m12,
        "tag_add": MessageLookupByLibrary.simpleMessage("Add tag"),
        "tag_choose_color":
            MessageLookupByLibrary.simpleMessage("Choose color"),
        "tag_color_message":
            MessageLookupByLibrary.simpleMessage("Enter color code (#02B13F)"),
        "tag_create": MessageLookupByLibrary.simpleMessage("Create tags"),
        "tag_edit": MessageLookupByLibrary.simpleMessage("Edit tag"),
        "tag_name_placeholder":
            MessageLookupByLibrary.simpleMessage("Enter tag name"),
        "v_cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "v_clear": MessageLookupByLibrary.simpleMessage("Clear"),
        "v_clear_all": MessageLookupByLibrary.simpleMessage("Clear all"),
        "v_confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "v_create": MessageLookupByLibrary.simpleMessage("Create"),
        "v_join": MessageLookupByLibrary.simpleMessage("Join"),
        "v_leaveGroup": MessageLookupByLibrary.simpleMessage("Leave"),
        "v_ok": MessageLookupByLibrary.simpleMessage("OK"),
        "v_open_google_map":
            MessageLookupByLibrary.simpleMessage("Open Google Map"),
        "v_open_map": MessageLookupByLibrary.simpleMessage("Open Map"),
        "v_save": MessageLookupByLibrary.simpleMessage("Save"),
        "v_send": MessageLookupByLibrary.simpleMessage("Send"),
        "v_shareWith": MessageLookupByLibrary.simpleMessage("Share with")
      };
}
