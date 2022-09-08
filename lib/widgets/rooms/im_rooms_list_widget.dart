import 'package:flutter/material.dart';
import 'package:imkit/gen/assets.gen.dart';
import 'package:imkit/models/im_room.dart';
import 'package:imkit/sdk/imkit.dart';
import 'package:imkit/utils/im_loading.dart';
import 'package:imkit/widgets/components/im_empty_widget.dart';
import 'package:imkit/widgets/rooms/im_rooms_list_item.dart';

class IMRoomsListWidget extends StatelessWidget {
  final Widget? emptyView;
  const IMRoomsListWidget({Key? key, this.emptyView}) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder<List<IMRoom>>(
        initialData: const [],
        stream: IMKit.instance.listener.watchRooms,
        builder: (BuildContext context, AsyncSnapshot<List<IMRoom>> snapshot) {
          ///获取到数据，为所欲为的更新 UI
          print(">>> room list count: ${snapshot.data?.length ?? 0}");
          // inspect(snapshot.data);
          //return Container();
          final itemCount = snapshot.data?.length ?? 0;
          if (itemCount <= 0 && IMKit.uid.isNotEmpty) {
            return emptyView ?? IMEmptyWidget(icon: Assets.images.emptyRooms, message: IMKit.S.rooms_empty);
          } else {
            return Stack(
              children: [
                ListView.separated(
                    itemBuilder: (BuildContext context, int index) => IMRoomsListItem(key: ObjectKey(snapshot.data![index].id), room: snapshot.data![index]),
                    separatorBuilder: (BuildContext context, int index) => const Divider(height: 1),
                    itemCount: IMKit.uid.isNotEmpty ? itemCount : 0),
                Visibility(
                  visible: snapshot.connectionState == ConnectionState.waiting,
                  child: IMLoading.view,
                ),
              ],
            );
          }
        },
      );
}
