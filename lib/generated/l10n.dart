// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class IMKitS {
  IMKitS();

  static IMKitS? _current;

  static IMKitS get current {
    assert(_current != null,
        'No instance of IMKitS was loaded. Try to initialize the IMKitS delegate before accessing IMKitS.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<IMKitS> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = IMKitS();
      IMKitS._current = instance;

      return instance;
    });
  }

  static IMKitS of(BuildContext context) {
    final instance = IMKitS.maybeOf(context);
    assert(instance != null,
        'No instance of IMKitS present in the widget tree. Did you add IMKitS.delegate in localizationsDelegates?');
    return instance!;
  }

  static IMKitS? maybeOf(BuildContext context) {
    return Localizations.of<IMKitS>(context, IMKitS);
  }

  /// `message`
  String get n_message {
    return Intl.message(
      'message',
      name: 'n_message',
      desc: '',
      args: [],
    );
  }

  /// `photo`
  String get n_photo {
    return Intl.message(
      'photo',
      name: 'n_photo',
      desc: '',
      args: [],
    );
  }

  /// `voice message`
  String get n_voice_message {
    return Intl.message(
      'voice message',
      name: 'n_voice_message',
      desc: '',
      args: [],
    );
  }

  /// `video`
  String get n_video {
    return Intl.message(
      'video',
      name: 'n_video',
      desc: '',
      args: [],
    );
  }

  /// `File`
  String get n_file {
    return Intl.message(
      'File',
      name: 'n_file',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get n_location {
    return Intl.message(
      'Location',
      name: 'n_location',
      desc: '',
      args: [],
    );
  }

  /// `sticker`
  String get n_sticker {
    return Intl.message(
      'sticker',
      name: 'n_sticker',
      desc: '',
      args: [],
    );
  }

  /// `Group members`
  String get n_groupMembers {
    return Intl.message(
      'Group members',
      name: 'n_groupMembers',
      desc: '',
      args: [],
    );
  }

  /// `No members`
  String get n_noMembers {
    return Intl.message(
      'No members',
      name: 'n_noMembers',
      desc: '',
      args: [],
    );
  }

  /// `Yesterday`
  String get n_yesterday {
    return Intl.message(
      'Yesterday',
      name: 'n_yesterday',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get n_today {
    return Intl.message(
      'Today',
      name: 'n_today',
      desc: '',
      args: [],
    );
  }

  /// `Translation`
  String get n_translation {
    return Intl.message(
      'Translation',
      name: 'n_translation',
      desc: '',
      args: [],
    );
  }

  /// `Unsupported Message`
  String get n_unsupported_message {
    return Intl.message(
      'Unsupported Message',
      name: 'n_unsupported_message',
      desc: '',
      args: [],
    );
  }

  /// `Search history`
  String get n_room_search_history {
    return Intl.message(
      'Search history',
      name: 'n_room_search_history',
      desc: '',
      args: [],
    );
  }

  /// `You sent a {args}`
  String s_You_sent_a(Object args) {
    return Intl.message(
      'You sent a $args',
      name: 's_You_sent_a',
      desc: '',
      args: [args],
    );
  }

  /// `{args1} sent a {args2}`
  String s_sent_a(Object args1, Object args2) {
    return Intl.message(
      '$args1 sent a $args2',
      name: 's_sent_a',
      desc: '',
      args: [args1, args2],
    );
  }

  /// `{args} joined the chat`
  String s_joined_the_chat(Object args) {
    return Intl.message(
      '$args joined the chat',
      name: 's_joined_the_chat',
      desc: '',
      args: [args],
    );
  }

  /// `{args} left the chat`
  String s_left_the_chat(Object args) {
    return Intl.message(
      '$args left the chat',
      name: 's_left_the_chat',
      desc: '',
      args: [args],
    );
  }

  /// `{args1} invited {args2}`
  String s_invited(Object args1, Object args2) {
    return Intl.message(
      '$args1 invited $args2',
      name: 's_invited',
      desc: '',
      args: [args1, args2],
    );
  }

  /// `{args} invited you to join the chat.`
  String s_invited_you_to_join_the_chat(Object args) {
    return Intl.message(
      '$args invited you to join the chat.',
      name: 's_invited_you_to_join_the_chat',
      desc: '',
      args: [args],
    );
  }

  /// `{args1} kicked {args2}`
  String s_kicked(Object args1, Object args2) {
    return Intl.message(
      '$args1 kicked $args2',
      name: 's_kicked',
      desc: '',
      args: [args1, args2],
    );
  }

  /// `You unsent a message`
  String get s_You_unsent_a_message {
    return Intl.message(
      'You unsent a message',
      name: 's_You_unsent_a_message',
      desc: '',
      args: [],
    );
  }

  /// `{args} unsent a message`
  String s_unsent_a_message(Object args) {
    return Intl.message(
      '$args unsent a message',
      name: 's_unsent_a_message',
      desc: '',
      args: [args],
    );
  }

  /// `Searching "{args}"`
  String s_search_keyword(Object args) {
    return Intl.message(
      'Searching "$args"',
      name: 's_search_keyword',
      desc: '',
      args: [args],
    );
  }

  /// `Search...`
  String get s_search_chat_history {
    return Intl.message(
      'Search...',
      name: 's_search_chat_history',
      desc: '',
      args: [],
    );
  }

  /// `Search...`
  String get s_search_chat_room {
    return Intl.message(
      'Search...',
      name: 's_search_chat_room',
      desc: '',
      args: [],
    );
  }

  /// `No search records`
  String get s_no_search_records {
    return Intl.message(
      'No search records',
      name: 's_no_search_records',
      desc: '',
      args: [],
    );
  }

  /// `No results found.`
  String get s_no_results_found {
    return Intl.message(
      'No results found.',
      name: 's_no_results_found',
      desc: '',
      args: [],
    );
  }

  /// `Clear all of your recent searches?`
  String get s_clear_all_of_your_recent_searches {
    return Intl.message(
      'Clear all of your recent searches?',
      name: 's_clear_all_of_your_recent_searches',
      desc: '',
      args: [],
    );
  }

  /// `You were mentioned.`
  String get s_You_were_mentioned {
    return Intl.message(
      'You were mentioned.',
      name: 's_You_were_mentioned',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get v_ok {
    return Intl.message(
      'OK',
      name: 'v_ok',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get v_confirm {
    return Intl.message(
      'Confirm',
      name: 'v_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get v_cancel {
    return Intl.message(
      'Cancel',
      name: 'v_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Leave`
  String get v_leaveGroup {
    return Intl.message(
      'Leave',
      name: 'v_leaveGroup',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get v_send {
    return Intl.message(
      'Send',
      name: 'v_send',
      desc: '',
      args: [],
    );
  }

  /// `Share with`
  String get v_shareWith {
    return Intl.message(
      'Share with',
      name: 'v_shareWith',
      desc: '',
      args: [],
    );
  }

  /// `Join`
  String get v_join {
    return Intl.message(
      'Join',
      name: 'v_join',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get v_clear {
    return Intl.message(
      'Clear',
      name: 'v_clear',
      desc: '',
      args: [],
    );
  }

  /// `Clear all`
  String get v_clear_all {
    return Intl.message(
      'Clear all',
      name: 'v_clear_all',
      desc: '',
      args: [],
    );
  }

  /// `Open Map`
  String get v_open_map {
    return Intl.message(
      'Open Map',
      name: 'v_open_map',
      desc: '',
      args: [],
    );
  }

  /// `Open Google Map`
  String get v_open_google_map {
    return Intl.message(
      'Open Google Map',
      name: 'v_open_google_map',
      desc: '',
      args: [],
    );
  }

  /// `Saved`
  String get p_p_saved {
    return Intl.message(
      'Saved',
      name: 'p_p_saved',
      desc: '',
      args: [],
    );
  }

  /// `Empty chat`
  String get rooms_cell_emptyChat {
    return Intl.message(
      'Empty chat',
      name: 'rooms_cell_emptyChat',
      desc: '',
      args: [],
    );
  }

  /// `Hide`
  String get rooms_action_hide {
    return Intl.message(
      'Hide',
      name: 'rooms_action_hide',
      desc: '',
      args: [],
    );
  }

  /// `Chat messages wouldn't be deleted`
  String get rooms_action_hide_alert {
    return Intl.message(
      'Chat messages wouldn\'t be deleted',
      name: 'rooms_action_hide_alert',
      desc: '',
      args: [],
    );
  }

  /// `Size`
  String get messages_fileCell_size {
    return Intl.message(
      'Size',
      name: 'messages_fileCell_size',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get messages_location {
    return Intl.message(
      'Location',
      name: 'messages_location',
      desc: '',
      args: [],
    );
  }

  /// `Current location`
  String get messages_location_current {
    return Intl.message(
      'Current location',
      name: 'messages_location_current',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get messages_action_resend {
    return Intl.message(
      'Resend',
      name: 'messages_action_resend',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get messages_action_delete {
    return Intl.message(
      'Delete',
      name: 'messages_action_delete',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get messages_action_cancel {
    return Intl.message(
      'Cancel',
      name: 'messages_action_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Reply`
  String get messages_action_reply {
    return Intl.message(
      'Reply',
      name: 'messages_action_reply',
      desc: '',
      args: [],
    );
  }

  /// `Forward`
  String get messages_action_forward {
    return Intl.message(
      'Forward',
      name: 'messages_action_forward',
      desc: '',
      args: [],
    );
  }

  /// `Copy`
  String get messages_action_copy {
    return Intl.message(
      'Copy',
      name: 'messages_action_copy',
      desc: '',
      args: [],
    );
  }

  /// `Share location`
  String get messages_action_shareLocation {
    return Intl.message(
      'Share location',
      name: 'messages_action_shareLocation',
      desc: '',
      args: [],
    );
  }

  /// `Unsend`
  String get messages_action_unsend {
    return Intl.message(
      'Unsend',
      name: 'messages_action_unsend',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get messages_action_edit {
    return Intl.message(
      'Edit',
      name: 'messages_action_edit',
      desc: '',
      args: [],
    );
  }

  /// `Report`
  String get messages_action_report {
    return Intl.message(
      'Report',
      name: 'messages_action_report',
      desc: '',
      args: [],
    );
  }

  /// `Edited`
  String get messages_edited {
    return Intl.message(
      'Edited',
      name: 'messages_edited',
      desc: '',
      args: [],
    );
  }

  /// `Tap here to open the link.`
  String get messages_linkPreview_tapOpen {
    return Intl.message(
      'Tap here to open the link.',
      name: 'messages_linkPreview_tapOpen',
      desc: '',
      args: [],
    );
  }

  /// `Read`
  String get messages_outgoingCell_read {
    return Intl.message(
      'Read',
      name: 'messages_outgoingCell_read',
      desc: '',
      args: [],
    );
  }

  /// `{args} is typing...`
  String messages_single_typing(Object args) {
    return Intl.message(
      '$args is typing...',
      name: 'messages_single_typing',
      desc: '',
      args: [args],
    );
  }

  /// `{args} are typing...`
  String messages_multiple_typing(Object args) {
    return Intl.message(
      '$args are typing...',
      name: 'messages_multiple_typing',
      desc: '',
      args: [args],
    );
  }

  /// `Several people are typing...`
  String get messages_several_typing {
    return Intl.message(
      'Several people are typing...',
      name: 'messages_several_typing',
      desc: '',
      args: [],
    );
  }

  /// `Enter tag name`
  String get tag_name_placeholder {
    return Intl.message(
      'Enter tag name',
      name: 'tag_name_placeholder',
      desc: '',
      args: [],
    );
  }

  /// `Create tags`
  String get tag_create {
    return Intl.message(
      'Create tags',
      name: 'tag_create',
      desc: '',
      args: [],
    );
  }

  /// `Add tag`
  String get tag_add {
    return Intl.message(
      'Add tag',
      name: 'tag_add',
      desc: '',
      args: [],
    );
  }

  /// `Choose color`
  String get tag_choose_color {
    return Intl.message(
      'Choose color',
      name: 'tag_choose_color',
      desc: '',
      args: [],
    );
  }

  /// `Enter color code (#02B13F)`
  String get tag_color_message {
    return Intl.message(
      'Enter color code (#02B13F)',
      name: 'tag_color_message',
      desc: '',
      args: [],
    );
  }

  /// `Edit tag`
  String get tag_edit {
    return Intl.message(
      'Edit tag',
      name: 'tag_edit',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get rooms_action_delete {
    return Intl.message(
      'Delete',
      name: 'rooms_action_delete',
      desc: '',
      args: [],
    );
  }

  /// `Read`
  String get rooms_action_read {
    return Intl.message(
      'Read',
      name: 'rooms_action_read',
      desc: '',
      args: [],
    );
  }

  /// `Tag`
  String get rooms_action_tag {
    return Intl.message(
      'Tag',
      name: 'rooms_action_tag',
      desc: '',
      args: [],
    );
  }

  /// `Mute`
  String get rooms_action_mute {
    return Intl.message(
      'Mute',
      name: 'rooms_action_mute',
      desc: '',
      args: [],
    );
  }

  /// `Pin`
  String get rooms_action_pin {
    return Intl.message(
      'Pin',
      name: 'rooms_action_pin',
      desc: '',
      args: [],
    );
  }

  /// `{args} chatrooms`
  String rooms_count(Object args) {
    return Intl.message(
      '$args chatrooms',
      name: 'rooms_count',
      desc: '',
      args: [args],
    );
  }

  /// `You have left the chatroom`
  String get rooms_leave {
    return Intl.message(
      'You have left the chatroom',
      name: 'rooms_leave',
      desc: '',
      args: [],
    );
  }

  /// `Chatroom`
  String get rooms_title {
    return Intl.message(
      'Chatroom',
      name: 'rooms_title',
      desc: '',
      args: [],
    );
  }

  /// `{args} selected`
  String photo_select_count(Object args) {
    return Intl.message(
      '$args selected',
      name: 'photo_select_count',
      desc: '',
      args: [args],
    );
  }

  /// `Save`
  String get v_save {
    return Intl.message(
      'Save',
      name: 'v_save',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get v_create {
    return Intl.message(
      'Create',
      name: 'v_create',
      desc: '',
      args: [],
    );
  }

  /// `Folder name`
  String get folder_name {
    return Intl.message(
      'Folder name',
      name: 'folder_name',
      desc: '',
      args: [],
    );
  }

  /// `Create folder`
  String get folder_create {
    return Intl.message(
      'Create folder',
      name: 'folder_create',
      desc: '',
      args: [],
    );
  }

  /// `Edit folder`
  String get folder_edit {
    return Intl.message(
      'Edit folder',
      name: 'folder_edit',
      desc: '',
      args: [],
    );
  }

  /// `Choose the chatrooms to add in this folder`
  String get folder_choose_room {
    return Intl.message(
      'Choose the chatrooms to add in this folder',
      name: 'folder_choose_room',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get rooms_action_edit {
    return Intl.message(
      'Edit',
      name: 'rooms_action_edit',
      desc: '',
      args: [],
    );
  }

  /// `There are currently no chat rooms`
  String get rooms_empty {
    return Intl.message(
      'There are currently no chat rooms',
      name: 'rooms_empty',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<IMKitS> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'ko'),
      Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
      Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<IMKitS> load(Locale locale) => IMKitS.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
