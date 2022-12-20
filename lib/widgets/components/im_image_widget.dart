import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:imkit/extensions/string_ext.dart';
import 'package:imkit/sdk/imkit.dart';
import 'package:imkit/utils/imkit_cache_manager.dart';

class IMImageWidget extends StatelessWidget {
  const IMImageWidget({
    Key? key,
    this.url,
    this.bytes,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.maxWidthDiskCache,
    this.maxHeightDiskCache,
    this.text,
    this.onError,
    this.onProgress,
    this.onImageBuilder,
  }) : super(key: key);

  final String? url;
  final Uint8List? bytes;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final int? maxWidthDiskCache;
  final int? maxHeightDiskCache;
  final String? text;
  final Function? onError;
  final Function(double?)? onProgress;
  final Function(ImageProvider<Object>)? onImageBuilder;

  @override
  Widget build(BuildContext context) => _getChild();

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
        cacheManager: IMKitCacheManager(),
        imageUrl: url ?? "",
        fit: fit,
        width: width,
        height: height,
        maxWidthDiskCache: maxWidthDiskCache,
        maxHeightDiskCache: maxHeightDiskCache,
        httpHeaders: IMKit.instance.internal.state.headers(),
        errorWidget: (context, url, error) {
          if (onError != null) {
            onError?.call();
          }
          return _fromText();
        },
        progressIndicatorBuilder: (BuildContext context, String url, DownloadProgress downloadProgress) {
          if (onProgress != null) {
            return onProgress?.call(downloadProgress.progress);
          }
          return CircularProgressIndicator(
            strokeWidth: 2,
            value: downloadProgress.progress,
          );
        },
        imageBuilder: onImageBuilder == null ? null : (BuildContext context, ImageProvider<Object> imageProvider) => onImageBuilder?.call(imageProvider),
      );

  Widget _fromMemory() => Image.memory(
        bytes ?? Uint8List(0),
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          if (onError != null) {
            onError?.call();
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
