import 'package:flutter/material.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/widgets/components/im_stateful_wrapper.dart';
import 'package:imkit/widgets/messages/im_messages_input_view.dart';
import 'package:imkit/widgets/messages/im_messages_list_widget.dart';

class IMMessagesView extends StatelessWidget {
  final String roomId;
  final IMRoom? room;

  const IMMessagesView({Key? key, required this.roomId, this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(room?.id);
    return IMStatefulWrapper(
      onInit: () => IMKit.instance.action.initEntryRoom(roomId: roomId),
      child: StreamBuilder<IMRoom?>(
        initialData: room,
        stream: IMKit.instance.listener.watchRoom(roomId: roomId),
        builder: (BuildContext context, AsyncSnapshot<IMRoom?> snapshot) => Scaffold(
          appBar: AppBar(title: Text(snapshot.data?.title ?? ""), backgroundColor: IMKit.style.primaryColor),
          body: GestureDetector(
            onTap: () => inputViewWidgetKey.currentState?.updateInputType(IMMessagesInputViewType.none),
            child: Column(
              children: [
                IMMessagesListWidget(roomId: roomId, room: snapshot.data),
                IMMessagesInputView(key: inputViewWidgetKey, roomId: roomId),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
