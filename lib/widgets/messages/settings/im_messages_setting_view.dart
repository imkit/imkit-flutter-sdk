import 'package:flutter/material.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/utils/loading.dart';
import 'package:imkit/widgets/components/im_text_button_widget.dart';
import 'package:imkit/widgets/messages/settings/im_messages_member_item.dart';

class IMMessagesSettingView extends StatelessWidget {
  final IMRoom room;
  const IMMessagesSettingView({Key? key, required this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<IMRoom?>(
      initialData: room,
      stream: IMKit.instance.listener.watchRoom(roomId: room.id),
      builder: (BuildContext context, AsyncSnapshot<IMRoom?> snapshot) => Scaffold(
        appBar: AppBar(title: Text(IMKit.S.n_groupMembers), backgroundColor: IMKit.style.primaryColor),
        backgroundColor: IMKit.style.backgroundColor,
        body: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: (snapshot.data?.members.length ?? 0) + 1,
          separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 0),
          itemBuilder: (BuildContext context, int index) {
            if (index < (snapshot.data?.members.length ?? 0)) {
              return IMMessagesMemberItem(user: snapshot.data!.members[index]);
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 66, vertical: 88),
                child: IMTextButtonWidget(
                  text: IMKit.S.v_leaveGroup,
                  onTap: () => IMLoading.exec(context: context, future: IMKit.instance.action.leaveRoom(roomId: room.id)).whenComplete(
                    () => Navigator.of(context)
                      ..pop()
                      ..pop(),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
