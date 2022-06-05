import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imkit/models/im_message.dart';
import 'package:imkit/sdk/imkit.dart';
import 'package:imkit/widgets/components/im_icon_button_widget.dart';

class IMMessageItemResend extends StatelessWidget {
  final IMMessage message;

  const IMMessageItemResend({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: IMKit.style.message.status.retryButtonBackgroundColor,
          shape: BoxShape.circle,
        ),
        child: IMIconButtonWidget(
          icon: Icon(Icons.refresh, color: IMKit.style.message.status.retryButtonColor),
          size: 24,
          iconSize: 18,
          onPressed: () => showCupertinoModalPopup<void>(
            context: context,
            builder: (BuildContext context) => CupertinoActionSheet(
              actions: [
                // I18n
                CupertinoActionSheetAction(
                  isDefaultAction: true,
                  child: const Text('messages.action.resend'),
                  onPressed: () {
                    IMKit.instance.action.resendMessage(message: message);
                    Navigator.pop(context);
                  },
                ),
                // I18n
                CupertinoActionSheetAction(
                  isDestructiveAction: true,
                  onPressed: () {
                    IMKit.instance.action.deleteMessage(message: message);
                    Navigator.pop(context);
                  },
                  child: const Text('messages.action.delete'),
                )
              ],
              // I18n
              cancelButton: CupertinoActionSheetAction(
                child: const Text('messages.action.cancel'),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ),
      );
}
