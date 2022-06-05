import 'dart:io';

import 'package:dio/dio.dart';
import 'package:imkit/models/im_upload_file.dart';
import 'package:retrofit/retrofit.dart';

part 'im_file_request.g.dart';

@RestApi(parser: Parser.JsonSerializable)
abstract class IMFileRequest {
  factory IMFileRequest(Dio dio, {String baseUrl}) = _IMFileRequest;

  @POST("/files/{bucket}")
  @MultiPart()
  Future<IMUploadFile> upload({
    @Header("Content-Type") required String mimeType,
    @Path("bucket") required String bucket,
    @Part(name: "file") required File file,
    @SendProgress() ProgressCallback? onSendProgress,
    @CancelRequest() CancelToken? cancelToken,
  });
}
