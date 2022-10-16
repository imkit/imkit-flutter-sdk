import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:imkit/sdk/internal/imkit_accessor.dart';
import 'package:imkit/services/network/api/interceptors/im_api_wrapper.dart';

class CloudTranslateApiDio with DioMixin, IMAccessor implements Dio {
  static CloudTranslateApiDio _instance() => CloudTranslateApiDio._();

  factory CloudTranslateApiDio() => _instance();

  CloudTranslateApiDio._([BaseOptions? options]) {
    options = BaseOptions()
      ..baseUrl = state.cloudTranslateAPIUrl
      ..contentType = Headers.jsonContentType
      ..connectTimeout = 60000
      ..sendTimeout = 180000
      ..receiveTimeout = 180000;

    this.options = options;

    interceptors.add(IMApiWrapper(sdk.state));

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
