import 'package:imkit/services/data/im_data.dart';

class IMKitAction {
  late final IMData _data;

  IMKitAction(IMData data) {
    _data = data;
  }

  // Socket
  void connect() {
    _data.socketConnect();
  }

  void disconnect() {
    _data.socketDisconnect();
  }

  // Room
  void fetchRooms({bool isRefresh = false}) {
    _data.syncRooms(isRefresh: isRefresh);
  }
}
