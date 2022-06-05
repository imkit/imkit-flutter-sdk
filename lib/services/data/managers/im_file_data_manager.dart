import 'dart:io';

import 'package:dio/dio.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/models/im_image.dart';
import 'package:imkit/models/im_upload_file.dart';
import 'package:imkit/sdk/internal/imkit_action.dart';
import 'package:imkit/services/data/managers/im_base_data_manager.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class IMFileDataManager extends IMBaseDataManager {
  Future<IMImage> uploadImage({required IMImage image, UploadProgress? uploadProgress, CancelToken? cancelToken}) async {
    const mimeType = "image/jpeg";
    double originalProgress = 0;
    double thumbnailProgress = 0;
    final original = upload(
        mimeType: mimeType,
        file: File(image.originalPath ?? ""),
        onSendProgress: (count, total) {
          originalProgress = count / total;
          uploadProgress?.call((originalProgress + thumbnailProgress) / 2);
        },
        cancelToken: cancelToken);
    final thumbnail = upload(
        mimeType: mimeType,
        file: File(image.thumbnailPath ?? ""),
        onSendProgress: (count, total) {
          thumbnailProgress = count / total;
          uploadProgress?.call((originalProgress + thumbnailProgress) / 2);
        },
        cancelToken: cancelToken);

    final results = await Future.wait([original, thumbnail]);
    final originalUrl = results[0].url;
    final thumbnailUrl = results[1].url;
    await downloadImageToCache(url: thumbnailUrl);
    return image
      ..originalUrl = originalUrl
      ..thumbnailUrl = thumbnailUrl;
  }

  Future<IMUploadFile> upload({required String mimeType, required File file, ProgressCallback? onSendProgress, CancelToken? cancelToken}) {
    return api.file.upload(
      mimeType: mimeType,
      bucket: IMKit.bucket,
      file: file,
      onSendProgress: onSendProgress,
      cancelToken: cancelToken,
    );
  }

  Future<FileInfo> downloadImageToCache({required String url}) {
    return DefaultCacheManager().downloadFile(url, authHeaders: IMKit.instance.internal.state.headers());
  }
}
