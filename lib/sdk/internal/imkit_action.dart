import 'package:dio/dio.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/services/data/im_data.dart';
import 'package:photo_manager/photo_manager.dart';

typedef UploadProgress = void Function(double progress);

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
  void fetchRooms({bool isRefresh = false}) => _data.syncRooms(isRefresh: isRefresh);

  // Message
  void fetchMessages({required String roomId}) => _data.syncMessages(roomId: roomId);
  void sendTextMessage({required String roomId, required String text}) => _data.sendTextMessage(roomId: roomId, text: text);
  void preSendImageMessage({required String roomId, required List<AssetEntity> assetEntities}) =>
      _data.preSendImageMessage(roomId: roomId, assetEntities: assetEntities);
  void sendImageMessage({required IMMessage message, UploadProgress? uploadProgress, CancelToken? cancelToken}) =>
      _data.sendImageMessage(message: message, uploadProgress: uploadProgress, cancelToken: cancelToken);
  void resendMessage({required IMMessage message}) => _data.resendMessage(message: message);
  void deleteMessage({required IMMessage message}) => _data.deleteMessage(message: message);
}
