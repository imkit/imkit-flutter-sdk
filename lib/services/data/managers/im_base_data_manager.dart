import 'package:imkit/sdk/imkit.dart';
import 'package:imkit/services/data/storage/im_local_storage.dart';
import 'package:imkit/services/network/api/im_api_client.dart';

abstract class IMBaseDataManager {
  late final IMApiClient api = IMApiClient();
  late final IMLocalStorage localStorege = IMKit.instance.getInternal().localStorage;
}
