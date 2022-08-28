import 'package:flutter/material.dart';
import 'package:imkit/models/im_room.dart';
import 'package:imkit/sdk/imkit.dart';
import 'package:imkit/widgets/rooms/im_rooms_list_item.dart';

class IMRoomsListWidget extends StatelessWidget {
  const IMRoomsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder<List<IMRoom>>(
        initialData: const [],
        stream: IMKit.instance.listener.watchRooms,
        builder: (BuildContext context, AsyncSnapshot<List<IMRoom>> snapshot) {
          ///获取到数据，为所欲为的更新 UI
          print(">>> room list count: ${snapshot.data?.length ?? 0}");
          // inspect(snapshot.data);
          //return Container();
          return ListView.separated(
              itemBuilder: (BuildContext context, int index) => IMRoomsListItem(key: ObjectKey(snapshot.data![index].id), room: snapshot.data![index]),
              separatorBuilder: (BuildContext context, int index) => const Divider(height: 1),
              itemCount: IMKit.uid.isNotEmpty ? snapshot.data?.length ?? 0 : 0);
        },
      );
}
