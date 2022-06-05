// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'im_file_request.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _IMFileRequest implements IMFileRequest {
  _IMFileRequest(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<IMUploadFile> upload(
      {required mimeType,
      required bucket,
      required file,
      onSendProgress,
      cancelToken}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'Content-Type': mimeType};
    _headers.removeWhere((k, v) => v == null);
    final _data = FormData();
    _data.files.add(MapEntry(
        'file',
        MultipartFile.fromFileSync(file.path,
            filename: file.path.split(Platform.pathSeparator).last)));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<IMUploadFile>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'multipart/form-data')
            .compose(_dio.options, '/files/${bucket}',
                queryParameters: queryParameters,
                data: _data,
                cancelToken: cancelToken,
                onSendProgress: onSendProgress)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = IMUploadFile.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
