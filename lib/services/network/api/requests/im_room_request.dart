import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:retrofit/retrofit.dart';

part 'im_room_request.g.dart';

@RestApi(parser: Parser.FlutterCompute)
abstract class IMRoomRequest {
  factory IMRoomRequest(Dio dio, {String baseUrl}) = _IMRoomRequest;

  @GET("/rooms")
  Future<List<IMRoom>> fetchRooms({
    @Query("skip") required int skip,
    @Query("limit") required int limit,
    @Query("updatedAfter") int? lastUpdatedAt,
    @Query("sort") String sort = "lastMessage",
  });
}
