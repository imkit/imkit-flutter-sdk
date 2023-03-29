import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:imkit/models/im_location.dart';
import 'package:imkit/sdk/imkit.dart';
import 'package:imkit/widgets/components/im_icon_button_widget.dart';

class TakeLocationScreen extends StatefulWidget {
  const TakeLocationScreen({Key? key}) : super(key: key);

  @override
  _TakeLocationScreenState createState() => _TakeLocationScreenState();
}

class _TakeLocationScreenState extends State<TakeLocationScreen> {
  GoogleMapController? _controller;
  LatLng? _centerLocation;
  String? _centerAddress;
  bool _isMoving = false;

  get _centerMarkerId => MarkerId(getCenterLatLng().toString());

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 300), () async {
      try {
        final position = await getPosition();
        _updateCenterLocation(LatLng(position.latitude, position.longitude));
      } catch (error) {
        _updateCenterLocation(const LatLng(0, 0));
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(IMKit.S.messages_action_shareLocation),
          actions: [
            IMIconButtonWidget(
              icon: const Icon(Icons.ios_share),
              onPressed: () {
                IMLocation? location;
                final latLng = _centerLocation;
                if (latLng != null) {
                  location = IMLocation(
                    address: _centerAddress ?? "",
                    latitude: latLng.latitude,
                    longitude: latLng.longitude,
                  );
                }
                Navigator.of(context).pop(location);
              },
            )
          ],
        ),
        body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: getCenterLatLng(),
            zoom: 17,
          ),
          compassEnabled: true,
          myLocationEnabled: true,
          padding: const EdgeInsets.only(right: 16, bottom: 40),
          markers: {
            Marker(
              markerId: _centerMarkerId,
              position: getCenterLatLng(),
              infoWindow: InfoWindow(title: "", snippet: _isMoving ? "" : _centerAddress),
              icon: BitmapDescriptor.defaultMarker,
            )
          },
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          },
          onCameraMove: (CameraPosition cameraPosition) {
            _isMoving = true;
            _updateCenterLocation(cameraPosition.target);
          },
          onCameraIdle: () async {
            _isMoving = false;
            getAddress().then((address) {
              if (!_isMoving) {
                _updateCenterAddress(address);
                _controller?.showMarkerInfoWindow(_centerMarkerId);
              }
            });
          },
          onTap: (LatLng latLng) async {
            _isMoving = true;
            _updateCenterLocation(latLng);
            _controller?.moveCamera(CameraUpdate.newLatLng(latLng));
          },
        ),
      );

  void _updateCenterLocation(LatLng latLng) {
    setState(() {
      _centerLocation = latLng;
    });
  }

  void _updateCenterAddress(String address) {
    setState(() {
      _centerAddress = address;
    });
  }
}

extension on _TakeLocationScreenState {
  LatLng getCenterLatLng() => _centerLocation ?? const LatLng(0, 0);

  Future<Position> getPosition() {
    return Geolocator.requestPermission().then((_) {
      return Geolocator.getCurrentPosition();
    }).catchError((error) {
      return Geolocator.getLastKnownPosition().then((value) {
        if (value != null) {
          return value;
        }
        throw error;
      });
    });
  }

  Future<String> getAddress() async {
    final latLng = getCenterLatLng();
    List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    geocoding.Placemark? place = placemarks.firstOrNull;
    if (place == null) {
      return "";
    }

    return [
      place.street,
      place.thoroughfare,
      place.locality,
      place.administrativeArea,
      place.country,
      place.postalCode,
    ].where((element) => (element ?? "").isNotEmpty).join(", ");
  }
}
//===================
// class TakeLocationScreen extends StatefulWidget {
//   // static const String route = 'latlng_screen_point_test_page';

//   const TakeLocationScreen({Key? key}) : super(key: key);

//   @override
//   State createState() {
//     return _TakeLocationScreenState();
//   }
// }

// class _TakeLocationScreenState extends State<TakeLocationScreen> {
//   late final MapController _mapController;

//   CustomPoint _textPos = const CustomPoint(10.0, 10.0);
//   LatLng currentLatLng = LatLng(0, 0);

//   @override
//   void initState() {
//     super.initState();
//     _mapController = MapController();

//     Future.delayed(Duration.zero, () => _updateCurrentLocation());
//   }

//   _updateCurrentLocation() async {
//     try {
//       final currentLocation = await Location().getLocation();
//       _mapController.move(
//         LatLng(currentLocation.latitude!, currentLocation.longitude!),
//         18,
//       );
//       currentLatLng =
//           LatLng(currentLocation.latitude!, currentLocation.longitude!);
//       final pt1 = _mapController.latLngToScreenPoint(
//           LatLng(currentLocation.latitude!, currentLocation.longitude!));
//       _textPos = CustomPoint(pt1!.x, pt1.y);
//       setState(() {});
//     } catch (e) {}
//   }

//   void onMapEvent(MapEvent mapEvent) {
//     if (mapEvent is! MapEventMove && mapEvent is! MapEventRotate) {
//       // do not flood console with move and rotate events
//       debugPrint(mapEvent.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             "位置訊息",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           actions: <Widget>[
//             Padding(
//                 padding: const EdgeInsets.only(right: 20.0),
//                 child: GestureDetector(
//                     onTap: () async {
//                       List<geocoding.Placemark> placemarks =
//                           await geocoding.placemarkFromCoordinates(
//                               currentLatLng.latitude, currentLatLng.longitude);
//                       String name = "";
//                       if (placemarks.isNotEmpty) {
//                         geocoding.Placemark place = placemarks.first;
//                         if (place.street != null) {
//                           name += place.street!;
//                         }

//                         if (place.thoroughfare != null) {
//                           if (name.isNotEmpty) {
//                             name += ", ";
//                           }
//                           name += place.thoroughfare!;
//                         }

//                         if (place.locality != null) {
//                           if (name.isNotEmpty) {
//                             name += ", ";
//                           }
//                           name += place.locality!;
//                         }

//                         if (place.administrativeArea != null) {
//                           if (name.isNotEmpty) {
//                             name += ", ";
//                           }
//                           name += place.administrativeArea!;
//                         }

//                         if (place.country != null) {
//                           if (name.isNotEmpty) {
//                             name += ", ";
//                           }
//                           name += place.country!;
//                         }

//                         if (place.postalCode != null) {
//                           if (name.isNotEmpty) {
//                             name += " ";
//                           }
//                           name += place.postalCode!;
//                         }
//                       }

//                       IMLocation location = IMLocation(
//                           address: name,
//                           latitude: currentLatLng.latitude,
//                           longitude: currentLatLng.longitude);
//                       Navigator.pop(context, location);
//                     },
//                     child: const Center(
//                         child: Text(
//                       "分享",
//                       style: TextStyle(
//                           fontSize: 16, fontWeight: FontWeight.normal),
//                     )))),
//           ],
//         ),
//         body: Stack(children: [
//           FlutterMap(
//             mapController: _mapController,
//             options: MapOptions(
//               onTap: (tapPos, latLng) {
//                 currentLatLng = latLng;
//                 final pt1 = _mapController.latLngToScreenPoint(latLng);
//                 _textPos = CustomPoint(pt1!.x, pt1.y);
//                 setState(() {});
//               },
//               center: LatLng(51.5, -0.09),
//               zoom: 11,
//               rotation: 0,
//             ),
//             layers: [
//               TileLayerOptions(
//                 urlTemplate:
//                     'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//                 subdomains: ['a', 'b', 'c'],
//                 userAgentPackageName: 'dev.fleaflet.flutter_map.example',
//               ),
//             ],
//           ),
//           Positioned(
//               left: _textPos.x.toDouble(),
//               top: _textPos.y.toDouble(),
//               width: 20,
//               height: 20,
//               child: Assets.images.locationMark.image(
//                   package:
//                       IMKit.instance.internal.state.sdkDefaultPackageName)),
//           Container(
//             padding: const EdgeInsets.all(14),
//             child: CurrentLocation(
//                 mapController: _mapController,
//                 callback: (currentLocation) {
//                   currentLatLng = LatLng(
//                       currentLocation.latitude!, currentLocation.longitude!);
//                 }),
//           )
//         ]));
//   }
// }

// typedef CurrentLocationCallback = void Function(LocationData data);

// class CurrentLocation extends StatefulWidget {
//   const CurrentLocation({
//     Key? key,
//     required this.mapController,
//     required this.callback,
//   }) : super(key: key);

//   final MapController mapController;
//   final CurrentLocationCallback callback;

//   @override
//   _CurrentLocationState createState() => _CurrentLocationState();
// }

// class _CurrentLocationState extends State<CurrentLocation> {
//   int _eventKey = 0;

//   // IconData icon = Icons.gps_not_fixed;
//   late final StreamSubscription<MapEvent> mapEventSubscription;

//   @override
//   void initState() {
//     super.initState();
//     mapEventSubscription =
//         widget.mapController.mapEventStream.listen(onMapEvent);
//   }

//   @override
//   void dispose() {
//     mapEventSubscription.cancel();
//     super.dispose();
//   }

//   // void setIcon(IconData newIcon) {
//   //   if (newIcon != icon && mounted) {
//   //     setState(() {
//   //       icon = newIcon;
//   //     });
//   //   }
//   // }

//   void onMapEvent(MapEvent mapEvent) {
//     if (mapEvent is MapEventMove && mapEvent.id != _eventKey.toString()) {
//       // setIcon(Icons.gps_not_fixed);
//     }
//   }

//   void _moveToCurrent() async {
//     _eventKey++;
//     final location = Location();

//     try {
//       final currentLocation = await location.getLocation();
//       final moved = widget.mapController.move(
//         LatLng(currentLocation.latitude!, currentLocation.longitude!),
//         18,
//         id: _eventKey.toString(),
//       );

//       // setIcon(moved ? Icons.gps_fixed : Icons.gps_not_fixed);
//       widget.callback(currentLocation);
//     } catch (e) {
//       // setIcon(Icons.gps_off);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // return IconButton(
//     //   icon: Icon(icon),
//     //   color: IMKit.style.inputBar.iconColor,
//     //   onPressed: _moveToCurrent,
//     // );
//     return InkWell(
//         onTap: () => _moveToCurrent(),
//         child: Assets.images.locationLocate.image(
//             package: IMKit.instance.internal.state.sdkDefaultPackageName));
//   }
// }
