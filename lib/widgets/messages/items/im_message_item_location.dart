import 'package:flutter/material.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/widgets/common/show_location_screen.dart';

class IMMessageItemLocation extends StatelessWidget {
  final IMMessage message;

  const IMMessageItemLocation({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () async {
          double latitude = 0;
          double longitude = 0;
          if (message.location != null) {
            latitude = message.location!.latitude;
            longitude = message.location!.longitude;
          }

          // if (await MapLauncher.isMapAvailable(MapType.google) ?? false) {
          //   MapLauncher.showMarker(
          //       mapType: MapType.google,
          //       coords: Coords(latitude, longitude),
          //       title: message.text ?? "");
          // } else {
          //   if (await MapLauncher.isMapAvailable(MapType.apple) ?? false) {
          //     MapLauncher.showMarker(
          //         mapType: MapType.apple,
          //         coords: Coords(latitude, longitude),
          //         title: message.text ?? "");
          //   } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ShowLocationScreen(
                latitude: latitude,
                longitude: longitude,
                address: message.text,
              ),
            ),
          );
          //   }
          // }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(Icons.location_on, color: IMKit.style.inputBar.iconColor),
              Flexible(child: Text(message.text ?? "", style: message.isMe ? IMKit.style.message.outgoing.textSytle : IMKit.style.message.incoming.textSytle))
            ],
          ),
        ),
      );
}
