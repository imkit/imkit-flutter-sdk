import 'package:dio/dio.dart';
import 'package:imkit/imkit_sdk.dart';

class IMApiTokenInterceptor extends QueuedInterceptorsWrapper {
  final Dio _dio;
  final IMState _state;

  final _headerAuthorization = "IM-Authorization";

  IMApiTokenInterceptor(this._dio, this._state);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers = _state.headersForApi();
    handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    try {
      switch (err.response?.statusCode) {
        case 401:
          final headers = err.requestOptions.headers;
          final inHeaderAccessToken = headers[_headerAuthorization];
          final inStateAccessToken = _state.token;
          return retry(
            err,
            (inHeaderAccessToken == inStateAccessToken) ? await IMKit.instance.internal.exchangeToken() : inStateAccessToken,
            handler,
          );
        default:
          return handler.reject(err);
      }
    } catch (error) {
      return handler.next(err);
    }
  }
}

extension on IMApiTokenInterceptor {
  void retry(DioError err, String accessToken, ErrorInterceptorHandler handler) async {
    if (accessToken.isNotEmpty) {
      try {
        err.requestOptions.headers
          ..remove(_headerAuthorization)
          ..putIfAbsent(_headerAuthorization, () => accessToken);

        final requestOptions = getRetryRequestOptions(err.requestOptions);
        final response = await Dio(_dio.options).request(
          requestOptions.path,
          data: requestOptions.data,
          queryParameters: requestOptions.queryParameters,
          options: Options(
            method: requestOptions.method,
            headers: requestOptions.headers,
          ),
        );
        return handler.resolve(response);
      } on DioError catch (error) {
        return handler.reject(error);
      }
    }
    return handler.reject(err);
  }

  RequestOptions getRetryRequestOptions(RequestOptions requestOptions) {
    if (requestOptions.data is FormData) {
      FormData formData = FormData();
      formData.fields.addAll(requestOptions.data.fields);

      for (MapEntry mapFile in formData.files) {
        formData.files.add(MapEntry(mapFile.key, MultipartFile.fromFileSync(mapFile.value.filePath, filename: mapFile.value.filename)));
      }
      requestOptions.data = formData;
    }
    return requestOptions;
  }
}
