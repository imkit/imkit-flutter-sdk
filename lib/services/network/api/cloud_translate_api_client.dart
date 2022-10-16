import 'package:imkit/services/network/api/cloud_translate_api_dio.dart';
import 'package:imkit/services/network/api/requests/cloud_translate_request.dart';

class CloudTranslateApiClient {
  late final dio = CloudTranslateApiDio();

  // Requests
  late final CloudTranslateRequest _auth = CloudTranslateRequest(dio);

  CloudTranslateRequest get auth => _auth;
}
