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
          final token = await IMKit.instance.internal.exchangeToken();
          if (token.isNotEmpty) {
            err.requestOptions.headers
              ..remove(_headerAuthorization)
              ..putIfAbsent(_headerAuthorization, () => token);
            return handler.resolve(await retry(_dio, err.requestOptions, handler));
          } else {
            return handler.reject(err);
          }

        default:
          return handler.next(err);
      }
    } catch (error) {
      return handler.next(err);
    }
  }
}

extension on IMApiTokenInterceptor {
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
