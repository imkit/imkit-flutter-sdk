import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/models/im_response_object.dart';
import 'package:imkit/services/data/im_data.dart';
import 'package:photo_manager/photo_manager.dart';

typedef UploadProgress = void Function(double progress);

class IMKitAction with WidgetsBindingObserver {
  late final IMData _data;

  IMKitAction(IMData data) {
    _data = data;
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      fetchRooms();
      connect();
    }
  }

  // Socket
  void connect() {
    _data.socketConnect();
  }

  void disconnect() {
    _data.socketDisconnect();
  }

  // User
  Future<IMUser> getMe() => _data.getMe();

  // Room
  void initEntryRoom({required String roomId}) => _data.initEntryRoom(roomId: roomId);
  void fetchRooms({bool isRefresh = false}) => _data.syncRooms(isRefresh: isRefresh);

  // Message
  Future<IMMessage> sendTextMessage({required String roomId, required String text, IMResponseObject? responseObject}) =>
      _data.sendTextMessage(roomId: roomId, text: text, responseObject: responseObject);
  Future<List<IMMessage>> preSendImageMessages({required String roomId, required List<AssetEntity> assetEntities}) =>
      _data.preSendImageMessages(roomId: roomId, assetEntities: assetEntities);
  Future<IMMessage> sendImageMessage({required IMMessage message, UploadProgress? uploadProgress, CancelToken? cancelToken}) =>
      _data.sendImageMessage(message: message, uploadProgress: uploadProgress, cancelToken: cancelToken);
  Future<IMMessage> resendMessage({required IMMessage message}) => _data.resendMessage(message: message);
  Future<IMMessage> recallMessage({required IMMessage message}) => _data.recallMessage(message: message);
  void deleteMessage({required IMMessage message}) => _data.deleteMessage(message: message);
  void setRead({required String roomId, required IMMessage message}) => _data.setReadIfNeed(roomId: roomId, message: message);
}
