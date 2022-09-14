import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';

class IMUrlPreviewWidget extends StatelessWidget {
  const IMUrlPreviewWidget({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.all(8),
      child: AnyLinkPreview(
        link: url,
        displayDirection: UIDirection.uiDirectionHorizontal,
        cache: const Duration(hours: 12),
        borderRadius: 4,
        removeElevation: false,
        previewHeight: (MediaQuery.of(context).size.height) * 0.1,
        titleStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        bodyStyle: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.normal,
          fontSize: 12,
        ),
        errorWidget: Container(
          color: Colors.grey[300],
          child: const Text('Oops!'),
        ),
        // errorImage: _errorImage,
      ));
}
