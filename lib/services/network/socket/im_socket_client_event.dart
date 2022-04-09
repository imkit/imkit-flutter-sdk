import 'package:imkit/models/im_invitation.dart';
import 'package:imkit/models/im_message.dart';
import 'package:imkit/models/im_room.dart';

typedef OnDidReceiveRoom = void Function(IMRoom room);
typedef OnDidReceiveMessage = void Function(IMMessage message);
typedef OnDidReceiveLastReadMessage = void Function(String roomId, String uid, String messageId);
typedef OnDidReceiveTyping = void Function(String roomId, String uid);
typedef OnDidReceiveInvitation = void Function(IMInvitation invitation);
typedef OnDidReceiveCancelInvitation = void Function(String invitationId);
typedef OnDidReceiveMyPrefChange = void Function(Map<String, dynamic> json);
typedef OnDidReceiveRoomPref = void Function(Map<String, dynamic> json);

class IMSocketClientEvent {
  late OnDidReceiveRoom onDidReceiveRoom;
  late OnDidReceiveMessage onDidReceiveMessage;
  late OnDidReceiveLastReadMessage onDidReceiveLastReadMessage;
  late OnDidReceiveTyping onDidReceiveTyping;
  late OnDidReceiveInvitation onDidReceiveInvitation;
  late OnDidReceiveCancelInvitation onDidReceiveCancelInvitation;
  late OnDidReceiveMyPrefChange onDidReceiveMyPrefChange;
  late OnDidReceiveRoomPref onDidReceiveRoomPref;
}
