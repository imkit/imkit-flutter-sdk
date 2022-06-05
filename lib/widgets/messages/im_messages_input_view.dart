import 'package:flutter/material.dart';
import 'package:imkit/sdk/imkit.dart';
import 'package:imkit/widgets/components/im_icon_button_widget.dart';
import 'package:imkit/widgets/messages/input_view/im_photo_input_view.dart';
import 'package:photo_manager/photo_manager.dart';

enum IMMessagesInputViewType {
  none,
  text,
  photo,
}

class IMMessagesInputView extends StatefulWidget {
  final String roomId;
  const IMMessagesInputView({Key? key, required this.roomId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => IMMessagesInputViewState();
}

class IMMessagesInputViewState extends State<IMMessagesInputView> {
  late final TextEditingController _controller = TextEditingController(text: "");
  final double _height = 36;
  final double _padding = 12;
  IMMessagesInputViewType _inputViewType = IMMessagesInputViewType.none;
  bool _isEditing = false;
  bool _isEnableInputText = true;
  List<AssetEntity> _selectedAssetEntities = [];

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
                          onPressed: () => {},
                        ),
                        // 相簿按鈕
                        IMIconButtonWidget(
                          size: _height,
                          icon: Icon(Icons.photo_library_outlined, color: IMKit.style.inputBar.iconColor),
                          onPressed: () => updateInputType(IMMessagesInputViewType.photo),
                        ),
                        // 文字輸入
                        Expanded(
                          child: TextFormField(
                              controller: _controller,
                              style: IMKit.style.inputBar.textFieldTextSytle,
                              keyboardType: TextInputType.multiline,
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
                            onPressed: () {
                              final text = _controller.text;
                              IMKit.instance.action.sendTextMessage(roomId: widget.roomId, text: text);
                              _controller.text = "";
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
                          // I18n
                          Text("photo.select.count" + _selectedAssetEntities.length.toString(), style: IMKit.style.inputBar.textFieldTextSytle),
                          // 送出按鈕
                          IMIconButtonWidget(
                            size: _height,
                            icon: Icon(Icons.send, color: IMKit.style.inputBar.iconColor),
                            onPressed: () {
                              IMKit.instance.action.preSendImageMessage(roomId: widget.roomId, assetEntities: _selectedAssetEntities);
                              updateInputType(IMMessagesInputViewType.none);
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
          ],
        ),
      );

  void updateInputType(IMMessagesInputViewType type) {
    if (type == _inputViewType) {
      return;
    }

    if (type != IMMessagesInputViewType.text) {
      FocusScope.of(context).unfocus();
    }

    setState(() {
      if (type == IMMessagesInputViewType.none) {
        _isEditing = false;
        _selectedAssetEntities.clear();
      }
      _inputViewType = type;
      _isEnableInputText = [IMMessagesInputViewType.none, IMMessagesInputViewType.text].contains(type);
    });
    setState(() {});
  }
}
