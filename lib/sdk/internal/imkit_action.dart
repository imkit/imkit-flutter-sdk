import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/models/im_location.dart';
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
    if (state == AppLifecycleState.resumed && IMKit.uid.isNotEmpty) {
      fetchRooms();
      _data.socketReconnectIfNeed();
    }
  }

  // User
  Future<IMUser> getMe() => _data.getMe();
  Future<IMUser> updateMe({String? nickname, String? avatarUrl, String? description}) => _data.updateMe(
        nickname: nickname,
        avatarUrl: avatarUrl,
        description: description,
      );

  // Room
  void initEntryRoom({required String roomId}) => _data.initEntryRoom(roomId: roomId);
  void fetchRooms({bool isRefresh = false}) => _data.syncRooms(isRefresh: isRefresh);
  Future<IMRoom> createRoom({String? roomId, String? roomName, String? description, String? cover}) => _data.createRoom(
        roomId: roomId,
        roomName: roomName,
        description: description,
        cover: cover,
      );
  Future<IMRoom> createDirectRoom(
          {required String invitee, String? roomId, String? roomName, String? description, String? cover, bool isSystemMessageEnabled = false}) =>
      _data.createDirectRoom(
          invitee: invitee, roomId: roomId, roomName: roomName, description: description, cover: cover, isSystemMessageEnabled: isSystemMessageEnabled);
  Future<IMRoom> createGroupRoom(
          {required String roomId,
          required List<String> invitees,
          String? roomName,
          String? description,
          String? cover,
          bool isSystemMessageEnabled = true,
          bool needsInvitation = false}) =>
      _data.createGroupRoom(
          invitees: invitees,
          roomId: roomId,
          roomName: roomName,
          description: description,
          cover: cover,
          isSystemMessageEnabled: isSystemMessageEnabled,
          needsInvitation: needsInvitation);
  Future<IMRoom> joinRoom({required String roomId, bool isSystemMessageEnabled = true}) =>
      _data.joinRoom(roomId: roomId, isSystemMessageEnabled: isSystemMessageEnabled);

  // Message
  Future<IMMessage> sendTextMessage({required String roomId, required String text, IMResponseObject? responseObject}) =>
      _data.sendTextMessage(roomId: roomId, text: text, responseObject: responseObject);
  Future<List<IMMessage>> preSendImageMessages({required String roomId, required List<AssetEntity> assetEntities}) =>
      _data.preSendImageMessages(roomId: roomId, assetEntities: assetEntities);
  Future<IMMessage> preSendImageMessage({required String roomId, required String path, required int width, required int height}) =>
      _data.preSendImageMessage(roomId: roomId, path: path, width: width, height: height);
  Future<IMMessage> sendImageMessage({required IMMessage message, UploadProgress? uploadProgress, CancelToken? cancelToken}) =>
      _data.sendImageMessage(message: message, uploadProgress: uploadProgress, cancelToken: cancelToken);
  Future<IMMessage> sendLocationMessage({required String roomId, required IMLocation location, IMResponseObject? responseObject}) =>
      _data.sendLocationMessage(roomId: roomId, location: location, responseObject: responseObject);
  Future<IMMessage> sendStickerMessage({required String roomId, required String sticker, IMResponseObject? responseObject}) =>
      _data.sendStickerMessage(roomId: roomId, sticker: sticker, responseObject: responseObject);
  Future<IMMessage> preSendAudioMessage({required String roomId, required String path, required int duration, IMResponseObject? responseObject}) =>
      _data.preSendAudioMessage(roomId: roomId, path: path, duration: duration);
  Future<IMMessage> preSendFileMessage({required String roomId, required PlatformFile platformFile, IMResponseObject? responseObject}) =>
      _data.preSendFileMessage(roomId: roomId, platformFile: platformFile, responseObject: responseObject);
  Future<IMMessage> sendAndUploadFileMessage({required IMMessage message, UploadProgress? uploadProgress, CancelToken? cancelToken}) =>
      _data.sendAndUploadFileMessage(message: message, uploadProgress: uploadProgress, cancelToken: cancelToken);

  Future<IMMessage> resendMessage({required IMMessage message}) => _data.resendMessage(message: message);
  Future<IMMessage> recallMessage({required IMMessage message}) => _data.recallMessage(message: message);
  Future<IMMessage> editMessage({required IMMessage message}) => _data.editMessage(message: message);
  Future<bool> deleteLocalMessage({required IMMessage message}) => _data.deleteLocalMessage(message: message);
  void deleteMessage({required IMMessage message}) => _data.deleteMessage(message: message);
  void setRead({required String roomId, required IMMessage message}) => _data.setReadIfNeed(roomId: roomId, message: message);

  // File
  Future<File> downloadFileToCache({required String url, required String filename}) => _data.downloadFileToCache(url: url, filename: filename);

  // Settings
  Future<bool> leaveRoom({required String roomId}) => _data.leaveRoom(roomId: roomId);
}
