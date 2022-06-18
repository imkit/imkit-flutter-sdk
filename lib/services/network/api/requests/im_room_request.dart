import 'package:dio/dio.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/models/im_member_property.dart';
import 'package:retrofit/retrofit.dart';

part 'im_room_request.g.dart';

@RestApi(parser: Parser.JsonSerializable)
abstract class IMRoomRequest {
  factory IMRoomRequest(Dio dio, {String baseUrl}) = _IMRoomRequest;

  @GET("/rooms")
  Future<List<IMRoom>> fetchRooms({
    @Query("skip") required int skip,
    @Query("limit") required int limit,
    @Query("updatedAfter") int? lastUpdatedAt,
    @Query("sort") String sort = "lastMessage",
  });

  @GET("/rooms/{id}")
  Future<IMRoom> fetchRoom({
    @Path("id") required String roomId,
  });

  @PUT("/rooms/{id}/lastRead")
  Future<IMMemberProperty> setRead({
    @Path("id") required String roomId,
    @Field("message") required String lastReadMessageId,
  });
}
