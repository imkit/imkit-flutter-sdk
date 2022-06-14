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

  /// `聊天室`
  String get chat_room {
    return Intl.message(
      '聊天室',
      name: 'chat_room',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<IMKitS> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'zh'),
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
