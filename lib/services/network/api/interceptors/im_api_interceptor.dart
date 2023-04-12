import 'package:dio/dio.dart';

class IMApiInterceptor extends QueuedInterceptorsWrapper {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    dynamic result;
    try {
      result = response.data?["result"];
    } catch (error) {
      result = null;
    }

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
