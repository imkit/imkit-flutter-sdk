import 'package:imkit/sdk/imkit.dart';
import 'package:imkit/services/data/storage/im_local_storage.dart';
import 'package:imkit/services/db/im_database.dart';
import 'package:imkit/services/network/api/cloud_translate_api_client.dart';
import 'package:imkit/services/network/api/im_api_client.dart';

abstract class IMBaseDataManager {
  late final IMApiClient api = IMApiClient();
  late final CloudTranslateApiClient translateApi = CloudTranslateApiClient();
  late final IMLocalStorage localStorege = IMKit.instance.internal.localStorage;
  late final IMDatabase database = IMKit.instance.internal.database;
}
