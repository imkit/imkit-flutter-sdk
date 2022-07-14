import 'package:flutter/material.dart';
import 'package:imkit/sdk/imkit.dart';
import 'package:imkit/widgets/components/im_route_listen_widget.dart';
import 'package:imkit/widgets/rooms/im_rooms_list_widget.dart';

class IMRoomsView extends StatelessWidget {
  const IMRoomsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => IMRouteListenWidget(
        onAppear: (_) => IMKit.instance.action.fetchRooms(),
        child: RefreshIndicator(
            onRefresh: () => Future.delayed(const Duration(milliseconds: 500), () {
                  IMKit.instance.action.fetchRooms(isRefresh: true);
                }),
            child: const IMRoomsListWidget()),
      );
}
