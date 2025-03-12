import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:imkit/sdk/internal/imkit_accessor.dart';
import 'package:imkit/services/network/api/interceptors/im_api_interceptor.dart';

class CloudTranslateApiDio with DioMixin, IMAccessor implements Dio {
  static CloudTranslateApiDio _instance() => CloudTranslateApiDio._();

  factory CloudTranslateApiDio() => _instance();

  CloudTranslateApiDio._([BaseOptions? options]) {
    options = BaseOptions()
      ..baseUrl = state.cloudTranslateAPIUrl
      ..contentType = Headers.jsonContentType
      ..connectTimeout = const Duration(seconds: 60)
      ..sendTimeout = const Duration(seconds: 180)
      ..receiveTimeout = const Duration(seconds: 180);

    this.options = options;

    interceptors.add(IMApiInterceptor());

    // if (kDebugMode) {
    //   interceptors.add(PrettyDioLogger(
    //     request: true,
    //     requestHeader: true,
    //     requestBody: true,
    //     responseHeader: true,
    //     responseBody: true,
    //     compact: true,
    //   ));
    // }

    httpClientAdapter = IOHttpClientAdapter();
  }
}
