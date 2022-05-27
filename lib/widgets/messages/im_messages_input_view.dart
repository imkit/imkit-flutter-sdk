import 'package:flutter/material.dart';
import 'package:imkit/sdk/imkit.dart';
import 'package:imkit/widgets/components/im_icon_button_widget.dart';

class IMMessagesInputView extends StatefulWidget {
  const IMMessagesInputView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IMMessagesInputViewState();
}

class _IMMessagesInputViewState extends State<IMMessagesInputView> {
  late final TextEditingController controller = TextEditingController(text: "");
  final double height = 36;
  final double padding = 12;
  bool _isEditing = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: padding, horizontal: padding / 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // 相機按鈕
              IMIconButtonWidget(size: height, icon: Icon(Icons.photo_camera_outlined, color: IMKit.style.inputBar.iconColor), onPressed: null),
              // 相簿按鈕
              IMIconButtonWidget(size: height, icon: Icon(Icons.photo_library_outlined, color: IMKit.style.inputBar.iconColor), onPressed: null),
              // 文字輸入
              Expanded(
                child: TextFormField(
                    controller: controller,
                    style: IMKit.style.inputBar.textFieldTextSytle,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 3,
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
                    onChanged: (value) {
                      final isNotEmpty = value.isNotEmpty;
                      if (_isEditing != isNotEmpty) {
                        setState(() {
                          _isEditing = isNotEmpty;
                        });
                      }
                    }),
              ),
              // 錄音按鈕
              Visibility(
                visible: !_isEditing,
                child: IMIconButtonWidget(
                  size: height,
                  icon: Icon(Icons.mic_none_outlined, color: IMKit.style.inputBar.iconColor),
                  onPressed: () {},
                ),
              ),

              // 送出按鈕
              Visibility(
                visible: _isEditing,
                child: IMIconButtonWidget(
                  size: height,
                  icon: Icon(Icons.send, color: IMKit.style.inputBar.iconColor),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
