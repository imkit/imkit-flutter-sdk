import 'package:flutter/material.dart';
import 'package:imkit/sdk/imkit.dart';
import 'package:imkit/widgets/components/im_route_listen_widget.dart';
import 'package:imkit/widgets/rooms/im_rooms_list_widget.dart';

class IMRoomsView extends StatelessWidget {
  final Widget? emptyView;
  const IMRoomsView({Key? key, this.emptyView}) : super(key: key);

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: IMRouteListenWidget(
          onAppear: (_) => IMKit.uid.isNotEmpty ? IMKit.instance.action.fetchRooms() : null,
          child: RefreshIndicator(
              onRefresh: () => Future.delayed(const Duration(milliseconds: 500), () {
                    if (IMKit.uid.isNotEmpty) {
                      IMKit.instance.action.fetchRooms(isRefresh: true);
                    }
                  }),
              child: IMRoomsListWidget(emptyView: emptyView)),
        ),
      );
}
