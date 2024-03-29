import 'package:imkit/models/language_translate.dart';
import 'package:imkit/services/data/managers/im_base_data_manager.dart';

class LanguageDataManager extends IMBaseDataManager {
  Future<LanguageTranslate> doTranslate(
          {required String apiKey, required Map<String, dynamic> body}) =>
      translateApi.translate.doTranslate(apiKey: apiKey, body: body);
}
