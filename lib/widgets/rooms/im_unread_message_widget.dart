import 'package:flutter/material.dart';
import 'package:imkit/models/im_room.dart';
import 'package:imkit/sdk/imkit.dart';

class IMUnreadMessageWidget extends StatelessWidget {
  const IMUnreadMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder<List<IMRoom>>(
        initialData: const [],
        stream: IMKit.instance.listener.watchRooms,
        builder: (BuildContext context, AsyncSnapshot<List<IMRoom>> snapshot) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: IMKit.style.primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(11)),
            ),
            child: Text(
              (snapshot.data ?? []).map((e) => e.numberOfUnreadMessages).fold<int>(0, (previousValue, element) => previousValue + element).toString(),
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          );
        },
      );
}
