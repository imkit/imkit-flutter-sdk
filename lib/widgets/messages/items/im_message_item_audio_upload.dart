import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/widgets/components/im_icon_button_widget.dart';
import 'package:imkit/widgets/messages/items/im_message_item_component.dart';

class IMMessageItemAudioUpload extends StatefulWidget {
  final IMMessage message;
  const IMMessageItemAudioUpload({Key? key, required this.message}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IMMessageItemAudioUploadState();
}

class _IMMessageItemAudioUploadState extends State<IMMessageItemAudioUpload> {
  late final File _file = File(widget.message.images.firstOrNull?.thumbnailPath ?? "");
  late final CancelToken _cancelToken = CancelToken();
  late double _progress = 0;

  @override
  void initState() {
    super.initState();

    if ([IMMessageStatus.sent].contains(widget.message.status)) {
      Future.delayed(Duration.zero, _sendAudioMessage);
    }
  }

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.play_circle_fill_outlined, size: 28, color: IMKit.style.primaryColor),
            const SizedBox(width: 8),
            Text(widget.message.duration, style: widget.message.isMe ? IMKit.style.message.outgoing.textSytle : IMKit.style.message.incoming.textSytle)
          ],
        ),
      );

  // Stack(
  //       alignment: Alignment.center,
  //       children: [
  //         Image.file(
  //           _file,
  //           fit: BoxFit.fitWidth,
  //           errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) => IMMessageItemComponent.getLoadImageFailure(),
  //         ),
  //         Visibility(
  //           visible: _progress > 0,
  //           child: Container(
  //             width: 30,
  //             height: 30,
  //             decoration: BoxDecoration(
  //               color: Colors.black.withOpacity(0.4),
  //               shape: BoxShape.circle,
  //             ),
  //             child: Stack(
  //               children: [
  //                 CircularProgressIndicator(
  //                   strokeWidth: 2,
  //                   color: IMKit.style.primaryColor,
  //                   value: _progress,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         Visibility(
  //           visible: _progress > 0,
  //           child: IMIconButtonWidget(
  //             size: 28,
  //             icon: const Icon(Icons.close, color: Colors.white),
  //             onPressed: _cancelToken.cancel,
  //           ),
  //         ),
  //       ],
  //     );

  void _sendAudioMessage() => IMKit.instance.action.sendAudioMessage(
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
