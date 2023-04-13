import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:imkit/sdk/imkit.dart';

class ShowLocationScreen extends StatelessWidget {
  final double latitude;
  final double longitude;
  final String? address;

  ShowLocationScreen({
    Key? key,
    required this.latitude,
    required this.longitude,
    this.address,
  }) : super(key: key);

  late final LatLng _center = LatLng(latitude, longitude);
  get _centerMarkerId => MarkerId(_center.toString());

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(IMKit.S.n_location)),
        body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 17,
          ),
          compassEnabled: true,
          myLocationEnabled: true,
          padding: const EdgeInsets.only(right: 16, bottom: 40),
          markers: {
            Marker(
              markerId: _centerMarkerId,
              infoWindow: InfoWindow(title: "", snippet: address),
              position: _center,
            )
          },
          onMapCreated: (GoogleMapController controller) {
            controller.showMarkerInfoWindow(_centerMarkerId);
          },
        ),
      );
}
//======================
// class ShowLocationScreen extends StatefulWidget {
//   final double latitude;
//   final double longitude;

//   const ShowLocationScreen(
//       {Key? key, required this.latitude, required this.longitude})
//       : super(key: key);

//   @override
//   State createState() {
//     return _ShowLocationScreenState();
//   }
// }

// class _ShowLocationScreenState extends State<ShowLocationScreen> {
//   late final MapController _mapController;
//   CustomPoint _textPos = const CustomPoint(10.0, 10.0);

//   @override
//   void initState() {
//     super.initState();
//     _mapController = MapController();

//     Future.delayed(Duration.zero, () => _moveToMessageLocation());
//   }

//   _moveToMessageLocation() async {
//     LatLng latLng = LatLng(widget.latitude, widget.longitude);
//     _mapController.move(
//       latLng,
//       18,
//     );
//     final screenPoint = _mapController.latLngToScreenPoint(latLng);
//     setState(() {
//       _textPos = CustomPoint(screenPoint!.x, screenPoint.y);
//     });
//   }

//   void onMapEvent(MapEvent mapEvent) {
//     if (mapEvent is! MapEventMove && mapEvent is! MapEventRotate) {
//       // do not flood console with move and rotate events
//       debugPrint(mapEvent.toString());

//       LatLng latLng = LatLng(widget.latitude, widget.longitude);
//       final screenPoint = _mapController.latLngToScreenPoint(latLng);
//       _textPos = CustomPoint(screenPoint!.x, screenPoint.y);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Stack(children: [
//       FlutterMap(
//         mapController: _mapController,
//         options: MapOptions(
//           onTap: (tapPos, latLng) {},
//           center: LatLng(widget.latitude, widget.longitude),
//           interactiveFlags: InteractiveFlag.pinchZoom,
//           zoom: 11,
//           rotation: 0,
//         ),
//         layers: [
//           TileLayerOptions(
//             urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//             subdomains: ['a', 'b', 'c'],
//             userAgentPackageName: 'dev.fleaflet.flutter_map.example',
//           ),
//         ],
//       ),
//       Positioned(
//           left: _textPos.x.toDouble(),
//           top: _textPos.y.toDouble(),
//           width: 20,
//           height: 20,
//           child: Assets.images.locationMark.image(
//               package: IMKit.instance.internal.state.sdkDefaultPackageName))
//     ]));
//   }
// }
