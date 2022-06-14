import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:imkit/extensions/string_ext.dart';
import 'package:imkit/sdk/imkit.dart';

class IMCircleAvatarWidget extends StatelessWidget {
  const IMCircleAvatarWidget({
    Key? key,
    this.url,
    this.bytes,
    this.fit = BoxFit.cover,
    this.width = double.infinity,
    this.height = double.infinity,
    this.text,
    this.onLoadImageError,
  }) : super(key: key);

  final String? url;
  final Uint8List? bytes;
  final BoxFit fit;
  final double width;
  final double height;
  final String? text;
  final Function? onLoadImageError;

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        decoration: BoxDecoration(shape: BoxShape.circle, color: IMKit.style.avatar.backgroundColor),
        clipBehavior: Clip.hardEdge,
        child: _getChild(),
      );

  Widget _getChild() {
    try {
      if (url?.isNotEmpty ?? false) {
        return _fromNetwork();
      } else if (bytes?.isNotEmpty ?? false) {
        return _fromMemory();
      } else {
        return _fromText();
      }
    } catch (_) {
      return _fromText();
    }
  }

  Widget _fromNetwork() => CachedNetworkImage(
        imageUrl: url ?? "",
        fit: fit,
        width: width,
        height: height,
        httpHeaders: IMKit.instance.internal.state.headers(),
        errorWidget: (context, url, error) {
          if (onLoadImageError != null) {
            onLoadImageError?.call();
          }
          return _fromText();
        },
        progressIndicatorBuilder: (BuildContext context, String url, DownloadProgress downloadProgress) => CircularProgressIndicator(
          strokeWidth: 2,
          value: downloadProgress.progress,
        ),
      );

  Widget _fromMemory() => Image.memory(
        bytes ?? Uint8List(0),
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          if (onLoadImageError != null) {
            onLoadImageError?.call();
          }
          return _fromText();
        },
      );

  Widget _fromText() {
    final str = text ?? "";
    if (str.isNotEmpty) {
      return Center(child: Text(str.firstWord.toUpperCase(), style: IMKit.style.avatar.text));
    }
    return _empty();
  }

  Widget _empty() => const SizedBox();
}
