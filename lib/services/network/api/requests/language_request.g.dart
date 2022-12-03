// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_request.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _LanguageRequest implements LanguageRequest {
  _LanguageRequest(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<LanguageTranslate> doTranslate(
      {required apiKey, required body}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'key': apiKey};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LanguageTranslate>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/language/translate/v2',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LanguageTranslate.fromJson(_result.data!);
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
