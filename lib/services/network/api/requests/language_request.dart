import 'package:dio/dio.dart';
import 'package:imkit/models/language_translate.dart';
import 'package:retrofit/retrofit.dart';

part 'language_request.g.dart';

@RestApi(parser: Parser.JsonSerializable)
abstract class LanguageRequest {
  static const String endpoint = "/language";

  factory LanguageRequest(Dio dio, {String baseUrl}) = _LanguageRequest;

  // body : q as message, target as language
  @POST("$endpoint/translate/v2")
  Future<LanguageTranslate> doTranslate(
      {@Query("key") required String apiKey,
      @Body() required Map<String, dynamic> body});
}
