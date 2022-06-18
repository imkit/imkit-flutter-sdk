import 'package:flutter/material.dart';
import 'package:imkit/sdk/imkit.dart';
import 'package:imkit/widgets/components/im_stateful_wrapper.dart';
import 'package:imkit/widgets/rooms/im_rooms_list_widget.dart';

class IMRoomsView extends StatelessWidget {
  const IMRoomsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => IMStatefulWrapper(
        onInit: IMKit.instance.action.fetchRooms,
        child: Scaffold(
          appBar: AppBar(
            title: Text(IMKit.S.rooms_title),
            backgroundColor: IMKit.style.primaryColor,
          ),
          body: RefreshIndicator(
              onRefresh: () => Future.delayed(const Duration(milliseconds: 500), () {
                    IMKit.instance.action.fetchRooms(isRefresh: true);
                  }),
              child: const IMRoomsListWidget()),
        ),
      );
}
