import 'package:dio/dio.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/models/im_member_property.dart';
import 'package:retrofit/retrofit.dart';

part 'im_room_request.g.dart';

@RestApi(parser: Parser.JsonSerializable)
abstract class IMRoomRequest {
  static const String endpoint = "/rooms";
  factory IMRoomRequest(Dio dio, {String baseUrl}) = _IMRoomRequest;

  @GET(endpoint)
  Future<List<IMRoom>> fetchRooms({
    @Query("skip") required int skip,
    @Query("limit") required int limit,
    @Query("updatedAfter") int? lastUpdatedAt,
    @Query("sort") String sort = "lastMessage",
  });

  @POST(endpoint)
  Future<IMRoom> createRoom({
    @Field("_id") String? roomId,
    @Field("name") String? roomName,
    @Field("description") String? description,
    @Field("cover") String? cover,
  });

  @POST("$endpoint/createAndJoin")
  Future<IMRoom> createDirectRoom({
    @Field("_id") required String roomId,
    @Field("roomType") required String roomType,
    @Field("invitee") required String invitee,
    @Field("name") String? roomName,
    @Field("description") String? description,
    @Field("cover") String? cover,
    @Field("systemMessage") bool isSystemMessageEnabled = false,
  });

  @POST("$endpoint/createAndJoin")
  Future<IMRoom> createGroupRoom({
    @Field("_id") required String roomId,
    @Field("roomType") required String roomType,
    @Field("invitee") required List<String> invitees,
    @Field("name") String? roomName,
    @Field("description") String? description,
    @Field("cover") String? cover,
    @Field("systemMessage") bool isSystemMessageEnabled = true,
    @Field("invitationRequired") bool needsInvitation = false,
  });

  @POST("$endpoint/{id}/join")
  Future<IMRoom> joinRoom({
    @Path("id") required String roomId,
    @Field("systemMessage") bool isSystemMessageEnabled = true,
  });

  @GET("$endpoint/{id}")
  Future<IMRoom> fetchRoom({
    @Path("id") required String roomId,
  });

  @PUT("$endpoint/{id}/lastRead")
  Future<IMMemberProperty> setRead({
    @Path("id") required String roomId,
    @Field("message") required String lastReadMessageId,
  });

  @POST("$endpoint/{id}/delete/members")
  Future<IMRoom> removeMembers({
    @Path("id") required String roomId,
    @Field("members") required List<String> uids,
    @Field("systemMessage") required bool isSystemMessageEnabled,
  });
}
