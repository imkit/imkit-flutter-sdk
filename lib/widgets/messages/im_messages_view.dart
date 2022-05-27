import 'package:flutter/material.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/widgets/components/im_stateful_wrapper.dart';
import 'package:imkit/widgets/messages/im_messages_input_view.dart';
import 'package:imkit/widgets/messages/im_messages_list_widget.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class IMMessagesView extends StatelessWidget {
  final String roomId;
  final IMRoom? room;
  const IMMessagesView({Key? key, required this.roomId, this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IMStatefulWrapper(
      onInit: () => IMKit.instance.action.fetchMessages(roomId: roomId),
      child: KeyboardDismisser(
        child: StreamBuilder<IMRoom?>(
          initialData: room,
          stream: IMKit.instance.listener.watchRoom(roomId: roomId),
          builder: (BuildContext context, AsyncSnapshot<IMRoom?> snapshot) {
            return Scaffold(
              appBar: AppBar(title: Text(snapshot.data?.title ?? ""), backgroundColor: IMKit.style.primaryColor),
              body: Column(
                children: [
                  IMMessagesListWidget(roomId: roomId, room: snapshot.data),
                  const IMMessagesInputView(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
