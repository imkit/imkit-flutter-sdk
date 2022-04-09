import 'package:imkit/models/im_state.dart';
import 'package:imkit/sdk/imkit.dart';
import 'package:imkit/sdk/internal/imkit_internal.dart';
import 'package:imkit/services/data/im_data.dart';
import 'package:imkit/services/data/storage/im_local_storage.dart';

abstract class IMAccessor {
  IMKitInternal get sdk => IMKit.instance.getInternal();
  IMState get state => sdk.state;
  IMLocalStorage get localStorege => sdk.localStorage;
  IMData get data => sdk.data;
}
