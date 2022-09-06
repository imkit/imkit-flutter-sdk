import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  static request(Permission permission, Function(bool granted) handler) async {
    PermissionStatus status = await permission.status;
    bool granted = status.isGranted;
    if (!granted) {
      final results = await permission.request();
      handler.call(results.isGranted);
    } else {
      handler.call(granted);
    }
  }
}
