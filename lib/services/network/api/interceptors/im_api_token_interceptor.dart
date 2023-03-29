import 'package:dio/dio.dart';
import 'package:imkit/imkit_sdk.dart';

class IMApiTokenInterceptor extends Interceptor {
  final Dio _dio;

  final _headerAuthorization = '"IM-Authorization"';

  IMApiTokenInterceptor(this._dio);

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    try {
      switch (err.response?.statusCode) {
        case 401:
        case 403:
          return Future.delayed(const Duration(seconds: 3), () async {
            final headers = err.requestOptions.headers;
            final inHeaderAccessToken = headers[_headerAuthorization];
            final inStateAccessToken = IMKit.instance.internal.state.token;
            return resend(
              err,
              (inHeaderAccessToken == inStateAccessToken) ? await IMKit.instance.internal.exchangeToken() : inStateAccessToken,
              handler,
            );
          });

        default:
          return handler.next(err);
      }
    } catch (error) {
      return handler.next(err);
    }
  }
}

extension on IMApiTokenInterceptor {
  void resend(DioError err, String accessToken, ErrorInterceptorHandler handler) async {
    if (accessToken.isNotEmpty) {
      try {
        err.requestOptions.headers
          ..remove(_headerAuthorization)
          ..putIfAbsent(_headerAuthorization, () => accessToken);
        return handler.resolve(await retry(_dio, err.requestOptions, handler));
      } on DioError catch (error) {
        return handler.reject(error);
      }
    }
    return handler.reject(err);
  }

  Future retry(Dio dio, RequestOptions requestOptions, ErrorInterceptorHandler handler) {
    if (requestOptions.data is FormData) {
      FormData formData = FormData();
      formData.fields.addAll(requestOptions.data.fields);

      for (MapEntry mapFile in formData.files) {
        formData.files.add(MapEntry(mapFile.key, MultipartFile.fromFileSync(mapFile.value.filePath, filename: mapFile.value.filename)));
      }
      requestOptions.data = formData;
    }

    return dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: Options(
        method: requestOptions.method,
        headers: requestOptions.headers,
      ),
    );
  }
}
