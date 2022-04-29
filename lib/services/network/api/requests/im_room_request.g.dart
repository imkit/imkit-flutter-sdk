// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'im_room_request.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _IMRoomRequest implements IMRoomRequest {
  _IMRoomRequest(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<IMRoom>> fetchRooms(
      {required skip,
      required limit,
      lastUpdatedAt,
      sort = "lastMessage"}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'skip': skip,
      r'limit': limit,
      r'updatedAfter': lastUpdatedAt,
      r'sort': sort
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<IMRoom>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/rooms',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = await compute(
        deserializeIMRoomList, _result.data!.cast<Map<String, dynamic>>());
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
