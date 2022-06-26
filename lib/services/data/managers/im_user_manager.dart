import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/services/data/managers/im_base_data_manager.dart';

class IMUserDataManager extends IMBaseDataManager {
  Future<void> insertItem(IMUser user) {
    return database.userDao.insertItem(user);
  }

  Future<void> insertItems(List<IMUser> users) {
    return database.userDao.insertItems(users);
  }

  Future<IMUser> getMe() async {
    IMUser? me = await _findMe();
    if (me == null) {
      me = await _fetchMe();
      insertItem(me);
    }
    return me;
  }

  void syncMe() async {
    insertItem(await _fetchMe());
  }

  Future<IMUser?> _findMe() {
    return database.userDao.findUser(IMKit.uid);
  }

  Future<IMUser> _fetchMe() {
    return api.user.fetchMe();
  }
}
