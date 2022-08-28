import 'package:dio/dio.dart';
import 'package:imkit/models/im_client.dart';

import 'package:retrofit/retrofit.dart';

part 'im_auth_request.g.dart';

@RestApi(parser: Parser.JsonSerializable)
abstract class IMAuthRequest {
  static const String endpoint = "/auths";

  factory IMAuthRequest(Dio dio, {String baseUrl}) = _IMAuthRequest;

  @POST("$endpoint/sign/v2")
  Future<IMClient> fetchToken({
    @Field("id") required String userId,
  });
}
