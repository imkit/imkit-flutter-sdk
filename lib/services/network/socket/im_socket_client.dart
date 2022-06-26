import 'dart:convert';

import 'package:enume/enume.dart';
import 'package:flutter/foundation.dart';
import 'package:imkit/models/im_invitation.dart';
import 'package:imkit/models/im_message.dart';
import 'package:imkit/models/im_room.dart';
import 'package:imkit/models/im_state.dart';
import 'package:imkit/services/network/socket/im_socket_client_event.dart';
import 'package:socket_io_client/socket_io_client.dart';

part 'im_socket_client.g.dart';

@Enume(nameMethod: false)
enum IMSocketClientEventType {
  @Value("connect")
  handshake,
  @Value("room")
  room,
  @Value("chat message")
  message,
  @Value("typing")
  typing,
  @Value("lastRead")
  lastRead,
  @Value("conf")
  conf,
  @Value("invitation")
  invitation,
  @Value("cancelInvitation")
  cancelInvitation,
  @Value("myPrefChange")
  myPrefChange,
  @Value("roomPref")
  roomPref,
}

@Enume(nameMethod: false)
enum IMSocketClientEncodingType {
  @Value("base64")
  base64,
  @Value("custom")
  custom,
}

Map<String, dynamic> _convertSocketData(dynamic data) {
  try {
    return json.decode(utf8.decode(base64.decode(data ?? "")));
  } catch (_) {
    return {};
  }
}

class IMSocketClient {
  late final IMSocketClientEncodingType _encodingType = IMSocketClientEncodingType.base64;
  late final IMSocketClientEvent _event;
  late final IMState _state;
  late Socket _socket;

  IMSocketClient({required IMState state, required IMSocketClientEvent event}) {
    assert(state.chatServerURL.isNotEmpty, 'Must configure `chatServerURL` before initializing SocketClient');

    _state = state;
    _event = event;

    _socket = io(
      state.chatServerURL,
      OptionBuilder()
          .setTransports(['websocket'])
          .enableForceNew()
          .disableAutoConnect()
          .enableReconnection()
          .setReconnectionAttempts(-1)
          .setReconnectionDelay(1)
          .setReconnectionDelayMax(5)
          .build(),
    );
    _socket.compress(true);
  }

  connect() {
    assert(_state.chatServerURL.isNotEmpty, 'Must configure `chatServerURL` before socket connecting');
    assert(_state.uid.isNotEmpty, 'Must configure `uid` before socket connecting');
    assert(_state.token.isNotEmpty, 'Must configure `token` before socket connecting');

    _socket.clearListeners();
    _addEvents();
    _socket = _socket.open();
  }

  reconnect() {
    disconnect();
    connect();
  }

  disconnect() {
    _socket.dispose();
  }

  bool get isConnected => _socket.connected;
}

// Events
extension on IMSocketClient {
  _addEvents() {
    _socket.on(IMSocketClientEventType.handshake.value, _onHandshakeEvent);
    _socket.on(IMSocketClientEventType.room.value, _onRoomEvent);
    _socket.on(IMSocketClientEventType.message.value, _onMessageEvent);
    _socket.on(IMSocketClientEventType.typing.value, _onTypingEvent);
    _socket.on(IMSocketClientEventType.lastRead.value, _onLastReadEvent);
    _socket.on(IMSocketClientEventType.invitation.value, _onInvitationEvent);
    _socket.on(IMSocketClientEventType.cancelInvitation.value, _onCancelInvitationEvent);
    _socket.on(IMSocketClientEventType.myPrefChange.value, _onMyPrefChangeEvent);
    _socket.on(IMSocketClientEventType.roomPref.value, _onRoomPrefEvent);
  }

  _onHandshakeEvent(dynamic data) {
    _socket.emitWithAck("conf", {"encoding": _encodingType.value}, ack: (data) {
      _socket.emitWithAck("auth2", [_state.token, _state.headers()], ack: (data) {
        if (data == null || data == "NO ACK") {
          reconnect();
        } else if (_convertSocketData(data)["RC"] == 401) {
          disconnect();
        }
      });
    });
  }

  _onRoomEvent(dynamic data) {
    compute(_convertSocketData, data).then((json) {
      if (json.isNotEmpty) {
        IMRoom room = IMRoom.fromJson(json);
        if (room.id.isNotEmpty) {
          _event.onDidReceiveRoom(room);
        }
      }
    });
  }

  _onMessageEvent(dynamic data) async {
    compute(_convertSocketData, data).then((json) {
      if (json.isNotEmpty) {
        IMMessage message = IMMessage.fromJson(json);
        if (message.roomId.isNotEmpty) {
          _event.onDidReceiveMessage(message);
        }
      }
    });
  }

  _onTypingEvent(dynamic data) {
    compute(_convertSocketData, data).then((json) {
      if (json.isNotEmpty) {
        _event.onDidReceiveTyping((json["room"] ?? "").toString(), (json["sender"] ?? "").toString());
      }
    });
  }

  _onLastReadEvent(dynamic data) {
    compute(_convertSocketData, data).then((json) {
      if (json.isNotEmpty) {
        _event.onDidReceiveLastReadMessage((json["roomID"] ?? "").toString(), (json["memberID"] ?? "").toString(), (json["messageID"] ?? "").toString());
      }
    });
  }

  _onInvitationEvent(dynamic data) {
    compute(_convertSocketData, data).then((json) {
      if (json.isNotEmpty) {
        _event.onDidReceiveInvitation(IMInvitation.fromJson(json));
      }
    });
  }

  _onCancelInvitationEvent(dynamic data) {
    compute(_convertSocketData, data).then((json) {
      if (json.isNotEmpty) {
        _event.onDidReceiveCancelInvitation((json["room"] ?? "").toString());
      }
    });
  }

  _onMyPrefChangeEvent(dynamic data) {
    compute(_convertSocketData, data).then((json) {
      if (json.isNotEmpty) {
        _event.onDidReceiveMyPrefChange(json);
      }
    });
  }

  _onRoomPrefEvent(dynamic data) {
    compute(_convertSocketData, data).then((json) {
      if (json.isNotEmpty) {
        _event.onDidReceiveRoomPref(json);
      }
    });
  }
}
