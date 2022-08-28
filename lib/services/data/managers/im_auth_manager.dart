import 'dart:io';

import 'package:imkit/models/im_client.dart';
import 'package:imkit/services/data/managers/im_base_data_manager.dart';

class IMAuthDataManager extends IMBaseDataManager {
  Future<IMClient> fetchToken({required String userId}) => api.auth.fetchToken(userId: userId);
}
