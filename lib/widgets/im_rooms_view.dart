import 'package:flutter/material.dart';
import 'package:imkit/sdk/imkit.dart';
import 'package:imkit/widgets/im_rooms_list_widget.dart';

class IMRoomsView extends StatefulWidget {
  const IMRoomsView({Key? key}) : super(key: key);

  @override
  _IMRoomsWidgetState createState() => _IMRoomsWidgetState();
}

class _IMRoomsWidgetState extends State<IMRoomsView> {
  @override
  void initState() {
    super.initState();

    IMKit.instance.action.fetchRooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(IMKit.S.chat_room),
      ),
      body: RefreshIndicator(
          onRefresh: () => Future.delayed(const Duration(milliseconds: 500), () {
                IMKit.instance.action.fetchRooms(isRefresh: true);
              }),
          child: const IMRoomsListWidget()),
    );
  }
}
