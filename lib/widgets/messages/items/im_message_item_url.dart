import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/widgets/components/im_url_preview_widget.dart';

class IMMessageItemUrl extends StatelessWidget {
  final IMMessage message;
  final List<String> urls;

  const IMMessageItemUrl({Key? key, required this.message, required this.urls}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: getChildren(),
        ),
      );
}

extension on IMMessageItemUrl {
  List<Widget> getChildren() {
    List<Widget> widgets = [
      Text(message.text ?? "", style: message.isMe ? IMKit.style.message.outgoing.textSytle : IMKit.style.message.incoming.textSytle),
    ];
    widgets.addAll(urls.where((element) => IMUrlPreviewWidget.isUrlValid(element)).map((element) => IMUrlPreviewWidget(url: element)));

    return widgets;
  }
}
