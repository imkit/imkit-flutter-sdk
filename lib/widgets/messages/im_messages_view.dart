import 'package:flutter/material.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/widgets/components/im_icon_button_widget.dart';
import 'package:imkit/widgets/components/im_stateful_wrapper.dart';
import 'package:imkit/widgets/messages/im_messages_floating_action_widget.dart';
import 'package:imkit/widgets/messages/im_messages_input_view.dart';
import 'package:imkit/widgets/messages/im_messages_list_widget.dart';
import 'package:imkit/widgets/messages/settings/im_messages_setting_view.dart';

class IMMessagesView extends StatelessWidget with WidgetsBindingObserver {
  final String roomId;
  final IMRoom? room;

  const IMMessagesView({Key? key, required this.roomId, this.room}) : super(key: key);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      IMKit.instance.action.initEntryRoom(roomId: roomId);
    }
  }

  @override
  Widget build(BuildContext context) => IMStatefulWrapper(
        onInit: () {
          WidgetsBinding.instance?.addObserver(this);
          IMKit.instance.action.initEntryRoom(roomId: roomId);
        },
        onDispose: () {
          WidgetsBinding.instance?.removeObserver(this);
        },
        child: StreamBuilder<IMRoom?>(
          initialData: room,
          stream: IMKit.instance.listener.watchRoom(roomId: roomId),
          builder: (BuildContext context, AsyncSnapshot<IMRoom?> snapshot) => Scaffold(
            appBar: AppBar(
              title: Text(snapshot.data?.title ?? ""),
              backgroundColor: IMKit.style.primaryColor,
              actions: [
                IMIconButtonWidget(
                  padding: const EdgeInsets.only(right: 16),
                  icon: const Icon(Icons.settings_outlined, size: 24),
                  onPressed: () {
                    final room = snapshot.data;
                    if (room != null) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => IMMessagesSettingView(room: room)));
                    }
                  },
                )
              ],
            ),
            floatingActionButton: IMMessagesFloatingActionWidget(key: floatingActionWidgetKey),
            backgroundColor: IMKit.style.backgroundColor,
            body: GestureDetector(
              onTap: () => inputViewWidgetKey.currentState?.updateInputType(IMMessagesInputViewType.none),
              child: Column(
                children: [
                  IMMessagesListWidget(key: messagesListWidgetKey, roomId: roomId, room: snapshot.data),
                  IMMessagesInputView(key: inputViewWidgetKey, roomId: roomId),
                ],
              ),
            ),
          ),
        ),
      );
}
