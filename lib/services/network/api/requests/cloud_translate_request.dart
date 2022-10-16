import 'package:dio/dio.dart';
import 'package:imkit/models/im_client.dart';
import 'package:retrofit/retrofit.dart';

part 'cloud_translate_request.g.dart';

@RestApi(parser: Parser.JsonSerializable)
abstract class CloudTranslateRequest {
  // static const String endpoint = "/auths";

  factory CloudTranslateRequest(Dio dio, {String baseUrl}) =
      _CloudTranslateRequest;

  // body : q as message, target as language
  @POST("language/translate/v2")
  Future<IMClient> doTranslate(
      {@Query("key") required String apiKey,
      @Body() required Map<String, dynamic> body});
}
