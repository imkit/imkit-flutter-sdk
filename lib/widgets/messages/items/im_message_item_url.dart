import 'package:flutter/material.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/widgets/components/im_url_preview_widget.dart';

class IMMessageItemUrl extends StatelessWidget {
  final IMMessage message;
  final List<String> urls;

  const IMMessageItemUrl({Key? key, required this.message, required this.urls})
      : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            children: [
              Text(message.text ?? "",
                  style: message.isMe
                      ? IMKit.style.message.outgoing.textSytle
                      : IMKit.style.message.incoming.textSytle),
              const SizedBox(height: 4),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: urls.length,
                  itemBuilder: (BuildContext context, int index) {
                    return IMUrlPreviewWidget(url: urls[index]);
                  })
            ],
          ));
}
