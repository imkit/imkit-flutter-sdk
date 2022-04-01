import 'dart:async';

import 'package:imkit/models/im_invitation.dart';
import 'package:imkit/models/im_message.dart';
import 'package:imkit/models/im_room.dart';

class IMKitStreamManager {
  late StreamController<IMRoom> _didReceiveRoomStreamController;
  StreamController<IMRoom> get room => _didReceiveRoomStreamController;

  late StreamController<IMMessage> _didReceiveMessageStreamController;
  StreamController<IMMessage> get message => _didReceiveMessageStreamController;

  // late StreamController<IMMessageTyping> _didReceiveTypingStreamController;
  // StreamController<IMMessageTyping> get typing => _didReceiveTypingStreamController;

  // late StreamController<IMMessageLastRead> _didReceiveLastReadMessageStreamController;
  // StreamController<IMMessageLastRead> get lastReadMessage => _didReceiveLastReadMessageStreamController;

  late StreamController<IMInvitation> _didReceiveInvitationStreamController;
  StreamController<IMInvitation> get invitation => _didReceiveInvitationStreamController;

  late StreamController<String> _didReceiveCancelInvitationStreamController;
  StreamController<String> get cancelInvitation => _didReceiveCancelInvitationStreamController;

  late StreamController<Map<String, dynamic>> _didReceiveMyPrefChangeStreamController;
  StreamController<Map<String, dynamic>> get myPrefChange => _didReceiveMyPrefChangeStreamController;

  late StreamController<Map<String, dynamic>> _didReceiveRoomPrefChangeStreamController;
  StreamController<Map<String, dynamic>> get roomPrefChange => _didReceiveRoomPrefChangeStreamController;

  IMKitStreamManager() {
    _init();
  }

  _init() {
    _didReceiveRoomStreamController = StreamController<IMRoom>.broadcast();
    _didReceiveMessageStreamController = StreamController<IMMessage>.broadcast();
    // _didReceiveTypingStreamController = StreamController<IMMessageTyping>.broadcast();
    // _didReceiveLastReadMessageStreamController = StreamController<IMMessageLastRead>.broadcast();
    _didReceiveInvitationStreamController = StreamController<IMInvitation>.broadcast();
    _didReceiveCancelInvitationStreamController = StreamController<String>.broadcast();
    _didReceiveMyPrefChangeStreamController = StreamController<Map<String, dynamic>>.broadcast();
    _didReceiveRoomPrefChangeStreamController = StreamController<Map<String, dynamic>>.broadcast();
  }

  void reset() {
    _didReceiveRoomStreamController.close();
    _didReceiveMessageStreamController.close();
    // _didReceiveTypingStreamController.close();
    // _didReceiveLastReadMessageStreamController.close();
    _didReceiveInvitationStreamController.close();
    _didReceiveCancelInvitationStreamController.close();
    _didReceiveMyPrefChangeStreamController.close();
    _didReceiveRoomPrefChangeStreamController.close();

    _init();
  }
}
