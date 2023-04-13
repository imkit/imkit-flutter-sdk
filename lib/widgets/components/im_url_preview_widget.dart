import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/widgets/messages/items/im_message_item_component.dart';
import 'package:url_launcher/url_launcher.dart';

class IMUrlPreviewWidget extends StatelessWidget {
  const IMUrlPreviewWidget({Key? key, required this.url}) : super(key: key);

  final String url;
  final Duration _cacheDuration = const Duration(hours: 12);

  static bool isUrlValid(String url) => AnyLinkPreview.isValidLink(
        url,
        protocols: ['http', 'https'],
      );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Metadata?>(
      future: AnyLinkPreview.getMetadata(link: url, cache: _cacheDuration),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done || snapshot.data == null) {
          return const SizedBox();
        }
        return Padding(
          padding: const EdgeInsets.only(top: 8),
          child: AnyLinkPreview(
            link: url,
            displayDirection: UIDirection.uiDirectionHorizontal,
            cache: _cacheDuration,
            borderRadius: 4,
            removeElevation: false,
            previewHeight: IMMessageItemComponent.getPreviewCellHeight(context),
            titleStyle: IMKit.style.message.preview.titleStyle,
            bodyStyle: IMKit.style.message.preview.bodyStyle,
            // errorWidget: Container(
            //   height: height,
            //   color: Colors.grey[300],
            //   child: const Text('Oops!'),
            // ),
            urlLaunchMode: LaunchMode.externalApplication,
            // errorImage: _errorImage,
          ),
        );
      },
    );
  }
}
