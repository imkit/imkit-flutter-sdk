import 'package:dio/dio.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:retrofit/retrofit.dart';

part 'im_message_request.g.dart';

@RestApi(parser: Parser.JsonSerializable)
abstract class IMMessageRequest {
  factory IMMessageRequest(Dio dio, {String baseUrl}) = _IMMessageRequest;

  @GET("/rooms/{id}/messages/v3")
  Future<List<IMMessage>> fetchMessages({
    @Path("id") required String roomId,
    @Query("beforeMessage") String? beforeMessageId,
    @Query("limit") int? limit,
  });

  @POST("/rooms/{id}/message")
  Future<IMMessage> sendMessage({
    @Path("id") required String roomId,
    @Body() required Map<String, dynamic> body,
  });
}
