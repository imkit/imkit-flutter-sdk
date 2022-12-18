import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/widgets/components/im_icon_button_widget.dart';
import 'package:imkit/widgets/messages/items/im_message_item_file_view.dart';

class IMMessageItemFileUpload extends StatefulWidget {
  final IMMessage message;
  const IMMessageItemFileUpload({Key? key, required this.message}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IMMessageItemFileUploadState();
}

class _IMMessageItemFileUploadState extends State<IMMessageItemFileUpload> {
  late final CancelToken _cancelToken = CancelToken();
  late double _progress = 0;

  @override
  void initState() {
    super.initState();

    if ([IMMessageStatus.preSent].contains(widget.message.status)) {
      Future.delayed(Duration.zero, _sendMessage);
    }
  }

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.center,
        children: [
          IMMessageItemFileView(message: widget.message),
          Visibility(
            visible: _progress > 0,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
              child: Stack(
                children: [
                  CircularProgressIndicator(
                    strokeWidth: 2,
                    color: IMKit.style.primaryColor,
                    value: _progress,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: _progress > 0,
            child: IMIconButtonWidget(
              size: 28,
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: _cancelToken.cancel,
            ),
          ),
        ],
      );

  void _sendMessage() => IMKit.instance.action.sendAndUploadFileMessage(
      message: widget.message,
      uploadProgress: (progress) {
        if (mounted) {
          setState(() {
            _progress = progress;
          });
        }
      },
      cancelToken: _cancelToken);
}
