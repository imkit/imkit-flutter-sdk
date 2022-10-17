import 'package:imkit/services/network/api/cloud_translate_api_dio.dart';
import 'package:imkit/services/network/api/requests/language_request.dart';

class CloudTranslateApiClient {
  late final dio = CloudTranslateApiDio();

  // Requests
  late final LanguageRequest _translate = LanguageRequest(dio);

  LanguageRequest get translate => _translate;
}
