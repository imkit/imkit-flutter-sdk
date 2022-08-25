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

  @POST("/rooms")
  Future<IMRoom> createRoom({
    @Field("_id") String? roomId,
    @Field("name") String? roomName,
    @Field("description") String? description,
    @Field("cover") String? cover,
  });

  @POST("/rooms/createAndJoin")
  Future<IMRoom> createDirectRoom({
    @Field("_id") required String roomId,
    @Field("roomType") IMRoomType roomType = IMRoomType.direct,
    @Field("invitee") required String invitee,
    @Field("name") String? roomName,
    @Field("description") String? description,
    @Field("cover") String? cover,
    @Field("systemMessage") bool isSystemMessageEnabled = false,
  });

  @POST("/rooms/createAndJoin")
  Future<IMRoom> createGroupRoom({
    @Field("_id") required String roomId,
    @Field("roomType") IMRoomType roomType = IMRoomType.group,
    @Field("invitee") required List<String> invitees,
    @Field("name") String? roomName,
    @Field("description") String? description,
    @Field("cover") String? cover,
    @Field("systemMessage") bool isSystemMessageEnabled = true,
    @Field("invitationRequired") bool needsInvitation = false,
  });

  @POST("/rooms/{id}/join")
  Future<IMRoom> joinRoom({
    @Path("id") required String roomId,
    @Field("systemMessage") bool isSystemMessageEnabled = true,
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
