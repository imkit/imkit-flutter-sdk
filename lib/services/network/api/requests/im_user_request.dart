import 'package:dio/dio.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:retrofit/retrofit.dart';

part 'im_user_request.g.dart';

@RestApi(parser: Parser.JsonSerializable)
abstract class IMUserRequest {
  factory IMUserRequest(Dio dio, {String baseUrl}) = _IMUserRequest;

  @GET("/me")
  Future<IMUser> fetchMe();

  @POST("/me")
  Future<IMUser> updateMe({
    @Field("nickname") String? nickname,
    @Field("avatarUrl") String? avatarUrl,
    @Field("description") String? description,
  });
}
