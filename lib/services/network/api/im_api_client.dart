import 'package:imkit/services/network/api/im_api_dio.dart';
import 'package:imkit/services/network/api/requests/im_room_request.dart';

class IMApiClient {
  late final dio = IMApiDio();

  // Requests
  late final IMRoomRequest _room = IMRoomRequest(dio);
  IMRoomRequest get room => _room;
}
