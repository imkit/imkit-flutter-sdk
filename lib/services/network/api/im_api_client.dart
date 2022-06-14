import 'package:imkit/services/network/api/im_api_dio.dart';
import 'package:imkit/services/network/api/requests/im_file_request.dart';
import 'package:imkit/services/network/api/requests/im_message_request.dart';
import 'package:imkit/services/network/api/requests/im_room_request.dart';

class IMApiClient {
  late final dio = IMApiDio();

  // Requests
  late final IMRoomRequest _room = IMRoomRequest(dio);
  IMRoomRequest get room => _room;

  late final IMMessageRequest _message = IMMessageRequest(dio);
  IMMessageRequest get message => _message;

  late final IMFileRequest _file = IMFileRequest(dio);
  IMFileRequest get file => _file;
}
