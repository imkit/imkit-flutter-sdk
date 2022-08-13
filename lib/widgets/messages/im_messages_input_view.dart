import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:imkit/extensions/string_ext.dart';
import 'package:imkit/models/im_message.dart';
import 'package:imkit/models/im_response_object.dart';
import 'package:imkit/sdk/imkit.dart';
import 'package:imkit/utils/toast.dart';
import 'package:imkit/widgets/common/take_picture_screen.dart';
import 'package:imkit/widgets/components/im_circle_avatar_widget.dart';
import 'package:imkit/widgets/components/im_icon_button_widget.dart';
import 'package:imkit/widgets/components/im_rounded_image_widget.dart';
import 'package:imkit/widgets/messages/im_messages_list_widget.dart';
import 'package:imkit/widgets/messages/input_view/im_photo_input_view.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

import 'input_view/im_sticker_input_view.dart';

final GlobalKey<IMMessagesInputViewState> inputViewWidgetKey = GlobalKey();

enum IMMessagesInputViewType {
  none,
  text,
  photo,
  sticker,
}

class IMMessagesInputView extends StatefulWidget {
  final String roomId;
  const IMMessagesInputView({Key? key, required this.roomId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => IMMessagesInputViewState();
}

class IMMessagesInputViewState extends State<IMMessagesInputView> {
  late final TextEditingController _controller = TextEditingController(text: "");
  late final FocusNode _focusNode = FocusNode();
  final double _height = 36;
  final double _padding = 12;
  IMMessagesInputViewType _inputViewType = IMMessagesInputViewType.none;
  bool _isEditing = false;
  bool _isEnableInputText = true;
  List<AssetEntity> _selectedAssetEntities = [];
  IMResponseObject? _responseObject;
  IMMessage? _editMessage;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        child: Column(
          children: [
            Visibility(
              visible: _responseObject != null,
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: _padding),
                  child: Row(
                    children: [
                      IMCircleAvatarWidget(
                        text: _responseObject?.sender?.nickname,
                        url: _responseObject?.sender?.avatarUrl,
                        size: 32,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: _padding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_responseObject?.sender?.nickname ?? "", style: IMKit.style.message.response.titleTextSytle),
                              Text(
                                (_responseObject?.text ?? "").breakWord,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: IMKit.style.message.response.subtitleTextSytle,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: (_responseObject?.imageUrl ?? "").isNotEmpty,
                        child: Padding(
                          padding: EdgeInsets.only(left: _padding),
                          child: IMRoundedAvatarWidget(
                            url: _responseObject?.imageUrl,
                            size: 38,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: _padding, bottom: 14),
                        decoration: BoxDecoration(shape: BoxShape.circle, color: IMKit.style.avatar.backgroundColor),
                        child: IMIconButtonWidget(
                          size: 18,
                          iconSize: 14,
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              _responseObject = null;
                            });
                          },
                        ),
                      ),
                    ],
                  )),
            ),
            SafeArea(
              left: false,
              right: false,
              bottom: [IMMessagesInputViewType.none, IMMessagesInputViewType.text].contains(_inputViewType),
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: _padding, horizontal: _padding / 2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // 相機按鈕
                        IMIconButtonWidget(
                          size: _height,
                          icon: Icon(Icons.photo_camera_outlined, color: IMKit.style.inputBar.iconColor),
                          onPressed: () async {
                            var status = await Permission.camera.status;
                            bool granted = status.isGranted;
                            if (!granted) {
                              await [Permission.camera].request();
                              status = await Permission.camera.status;
                              granted = status.isGranted;
                            }

                            if (granted) {
                              final cameras = await availableCameras();
                              final AssetEntity result =
                                  await Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TakePictureScreen(
                                                  camera: cameras.first)));
                              if (result.relativePath != null) {
                                await IMKit.instance.action.preSendImageMessage(
                                    roomId: widget.roomId,
                                    path: result.relativePath!,
                                    width: result.width,
                                    height: result.height);
                                updateInputType(IMMessagesInputViewType.none);

                                messagesListWidgetKey.currentState
                                    ?.jumpToBottom();
                              }
                            } else {
                              Toast.basic(
                                  text: "Camera permission is not granted");
                            }
                          },
                        ),
                        // 相簿按鈕
                        IMIconButtonWidget(
                          size: _height,
                          icon: Icon(Icons.photo_library_outlined, color: IMKit.style.inputBar.iconColor),
                          onPressed: () => updateInputType(IMMessagesInputViewType.photo),
                        ),
                        // 文字輸入
                        Expanded(
                          child: Stack(children: [
                            TextFormField(
                                controller: _controller,
                                style: IMKit.style.inputBar.textFieldTextSytle,
                                keyboardType: TextInputType.multiline,
                                focusNode: _focusNode,
                                minLines: 1,
                                maxLines: 3,
                                readOnly: !_isEnableInputText,
                                decoration: InputDecoration(
                                  fillColor: IMKit.style.inputBar.textFieldBackgroundColor,
                                  filled: true,
                                  isDense: true,
                                  hintStyle: IMKit.style.inputBar.textFieldPlaceholderSytle,
                                  contentPadding: const EdgeInsets.all(8),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                onTap: () => updateInputType(IMMessagesInputViewType.text),
                                onChanged: (value) {
                                  final isNotEmpty = value.isNotEmpty;
                                  if (_isEditing != isNotEmpty) {
                                    setState(() {
                                      _isEditing = isNotEmpty;
                                    });
                                  }
                                }),
                            Align(
                              alignment: Alignment.centerRight,
                              child: IMIconButtonWidget(
                                size: _height,
                                icon: Icon(Icons.emoji_emotions_outlined, color: IMKit.style.inputBar.iconColor),
                                onPressed: () => {
                                  updateInputType(IMMessagesInputViewType.sticker)
                                },
                              )
                            )
                          ])
                        ),

                        // 送出按鈕 + // 錄音按鈕
                        Visibility(
                          visible: _isEditing,
                          replacement: IMIconButtonWidget(
                            size: _height,
                            icon: Icon(Icons.mic_none_outlined, color: IMKit.style.inputBar.iconColor),
                            onPressed: () {},
                          ),
                          child: IMIconButtonWidget(
                            size: _height,
                            icon: Icon(Icons.send, color: IMKit.style.inputBar.iconColor),
                            onPressed: () async {
                              final text = _controller.text;
                              final tmpResponseObject = _responseObject;
                              _controller.text = "";
                              setState(() {
                                _responseObject = null;
                              });
                              if (_editMessage != null) {
                                _editMessage?.text = text;
                                updateInputType(IMMessagesInputViewType.none);
                                await IMKit.instance.action.editMessage(message: _editMessage!);
                                _editMessage = null;
                              } else {
                                await IMKit.instance.action.sendTextMessage(roomId: widget.roomId, text: text, responseObject: tmpResponseObject);
                                messagesListWidgetKey.currentState?.jumpToBottom();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: _inputViewType == IMMessagesInputViewType.photo && _selectedAssetEntities.isNotEmpty,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: _padding, horizontal: _padding / 2),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // 關閉
                          IMIconButtonWidget(
                            size: _height,
                            icon: Icon(Icons.close, color: IMKit.style.inputBar.iconColor),
                            onPressed: () => updateInputType(IMMessagesInputViewType.none),
                          ),
                          Text(IMKit.S.photo_select_count(_selectedAssetEntities.length), style: IMKit.style.inputBar.textFieldTextSytle),
                          // 送出按鈕
                          IMIconButtonWidget(
                            size: _height,
                            icon: Icon(Icons.send, color: IMKit.style.inputBar.iconColor),
                            onPressed: () async {
                              await IMKit.instance.action.preSendImageMessages(roomId: widget.roomId, assetEntities: _selectedAssetEntities);
                              updateInputType(IMMessagesInputViewType.none);

                              messagesListWidgetKey.currentState?.jumpToBottom();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: _inputViewType == IMMessagesInputViewType.photo,
              child: IMPhotoInputView(
                onSelected: (entities) {
                  setState(() {
                    _selectedAssetEntities = entities;
                  });
                },
              ),
            ),
            Visibility(
              visible: _inputViewType == IMMessagesInputViewType.sticker,
              child: IMStickerInputView(
                onSelected: (sticker) async {
                  final tmpResponseObject = _responseObject;
                  setState(() {
                    _responseObject = null;
                  });
                  await IMKit.instance.action.sendStickerMessage(roomId: widget.roomId, sticker: sticker, responseObject: tmpResponseObject);
                  messagesListWidgetKey.currentState?.jumpToBottom();
                },
              ),
            ),
          ],
        ),
      );

  void updateInputType(IMMessagesInputViewType type) {
    if (type == _inputViewType) {
      return;
    }

    if (type != IMMessagesInputViewType.text) {
      _focusNode.unfocus();
    }

    setState(() {
      if (type == IMMessagesInputViewType.none) {
        _isEditing = false;
        _selectedAssetEntities.clear();
      }
      _inputViewType = type;
      _isEnableInputText = [IMMessagesInputViewType.none, IMMessagesInputViewType.text].contains(type);
    });
  }

  void editingMessage({required IMMessage message}) {
    _editMessage = message;
    final text = _editMessage?.text ?? "";
    updateInputType(IMMessagesInputViewType.text);
    _controller.value = _controller.value.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
    _focusNode.requestFocus();
    setState(() {
      _isEditing = text.isNotEmpty;
    });
  }

  void replay({required IMMessage message}) {
    setState(() {
      _responseObject = message.transformToResponseObject();
    });
    _focusNode.requestFocus();
  }
}
