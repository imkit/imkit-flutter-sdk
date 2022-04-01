import 'package:imkit/models/im_state.dart';
import 'package:imkit/sdk/imkit.dart';
import 'package:imkit/sdk/internal/imkit_internal.dart';
import 'package:imkit/services/network/im_socket_client.dart';

abstract class IMAccessor {
  IMKitInternal get sdk => IMKit.instance.getInternal();
  IMSocketClient get socketClient => sdk.socketClient;
  IMState get state => sdk.state;
}
