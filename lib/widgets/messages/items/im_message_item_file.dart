import 'package:flutter/material.dart';
import 'package:imkit/models/im_message.dart';
import 'package:imkit/widgets/messages/items/im_message_item_file_upload.dart';
import 'package:imkit/widgets/messages/items/im_message_item_file_view.dart';
import 'package:imkit/widgets/messages/sub_views/im_message_file_viewer.dart';

class IMMessageItemFile extends StatelessWidget {
  final IMMessage message;

  const IMMessageItemFile({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          final file = message.file;
          if (file != null && (file.url ?? "").isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => IMMessageFileViewer(message: message),
                fullscreenDialog: true,
              ),
            );
          }
        },
        child: getChild(),
      );
}

extension on IMMessageItemFile {
  Widget getChild() {
    switch (message.status) {
      case IMMessageStatus.preSent:
      case IMMessageStatus.sent:
        return IMMessageItemFileUpload(message: message);

      default:
        return IMMessageItemFileView(message: message);
    }
  }
}
