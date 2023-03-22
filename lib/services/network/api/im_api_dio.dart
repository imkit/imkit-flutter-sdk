import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:imkit/sdk/internal/imkit_accessor.dart';
import 'package:imkit/services/network/api/interceptors/im_api_token_interceptor.dart';
import 'package:imkit/services/network/api/interceptors/im_api_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class IMApiDio with DioMixin, IMAccessor implements Dio {
  static IMApiDio _instance() => IMApiDio._();

  factory IMApiDio() => _instance();

  IMApiDio._([BaseOptions? options]) {
    options = BaseOptions()
      ..baseUrl = state.chatServerURL
      ..contentType = Headers.jsonContentType
      ..connectTimeout = 60000
      ..sendTimeout = 180000
      ..receiveTimeout = 180000;

    this.options = options;

    interceptors.add(IMApiInterceptor(sdk.state));
    interceptors.add(IMApiTokenInterceptor(this));

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

    httpClientAdapter = DefaultHttpClientAdapter();
  }
}
