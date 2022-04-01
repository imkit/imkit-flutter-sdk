// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'im_socket_client.dart';

// **************************************************************************
// EnumeGenerator
// **************************************************************************

extension IMSocketClientEventTypevalue on IMSocketClientEventType {
  String get value {
    switch (this) {
      case IMSocketClientEventType.handshake:
        return 'connect';
      case IMSocketClientEventType.room:
        return 'room';
      case IMSocketClientEventType.message:
        return 'chat message';
      case IMSocketClientEventType.typing:
        return 'typing';
      case IMSocketClientEventType.lastRead:
        return 'lastRead';
      case IMSocketClientEventType.conf:
        return 'conf';
      case IMSocketClientEventType.invitation:
        return 'invitation';
      case IMSocketClientEventType.cancelInvitation:
        return 'cancelInvitation';
      case IMSocketClientEventType.myPrefChange:
        return 'myPrefChange';
      case IMSocketClientEventType.roomPref:
        return 'roomPref';
    }
  }
}

extension IMSocketClientEncodingTypevalue on IMSocketClientEncodingType {
  String get value {
    switch (this) {
      case IMSocketClientEncodingType.base64:
        return 'base64';
      case IMSocketClientEncodingType.custom:
        return 'custom';
    }
  }
}
