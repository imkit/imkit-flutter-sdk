import 'package:dio/dio.dart';
import 'package:imkit/models/im_state.dart';

class IMApiWrapper extends Interceptor {
  final IMState _state;

  IMApiWrapper(this._state);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers = _state.headersForApi();
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    dynamic result = response.data?["result"];

    if (result == null) {
      return handler.next(response);
    }

    dynamic data = result?["data"];
    if (data != null) {
      response.data = data;
    } else {
      response.data = result;
    }
    handler.next(response);
  }
}
