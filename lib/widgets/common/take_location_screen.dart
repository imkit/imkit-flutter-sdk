import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:imkit/gen/assets.gen.dart';
import 'package:imkit/models/im_location.dart';
import 'package:imkit/sdk/imkit.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class TakeLocationScreen extends StatefulWidget {
  // static const String route = 'latlng_screen_point_test_page';

  const TakeLocationScreen({Key? key}) : super(key: key);

  @override
  State createState() {
    return _TakeLocationScreenState();
  }
}

class _TakeLocationScreenState extends State<TakeLocationScreen> {
  late final MapController _mapController;

  CustomPoint _textPos = const CustomPoint(10.0, 10.0);
  LatLng currentLatLng = LatLng(0, 0);

  @override
  void initState() {
    super.initState();
    _mapController = MapController();

    Future.delayed(Duration.zero, () => _updateCurrentLocation());
  }

  _updateCurrentLocation() async {
    try {
      final currentLocation = await Location().getLocation();
      _mapController.move(
        LatLng(currentLocation.latitude!, currentLocation.longitude!),
        18,
      );
      currentLatLng =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);
      final pt1 = _mapController.latLngToScreenPoint(
          LatLng(currentLocation.latitude!, currentLocation.longitude!));
      _textPos = CustomPoint(pt1!.x, pt1.y);
      setState(() {});
    } catch (e) {}
  }

  void onMapEvent(MapEvent mapEvent) {
    if (mapEvent is! MapEventMove && mapEvent is! MapEventRotate) {
      // do not flood console with move and rotate events
      debugPrint(mapEvent.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "位置訊息",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                    onTap: () async {
                      List<geocoding.Placemark> placemarks =
                          await geocoding.placemarkFromCoordinates(
                              currentLatLng.latitude, currentLatLng.longitude);
                      String name = "";
                      if (placemarks.isNotEmpty) {
                        geocoding.Placemark place = placemarks.first;
                        if (place.street != null) {
                          name += place.street!;
                        }

                        if (place.thoroughfare != null) {
                          if (name.isNotEmpty) {
                            name += ", ";
                          }
                          name += place.thoroughfare!;
                        }

                        if (place.locality != null) {
                          if (name.isNotEmpty) {
                            name += ", ";
                          }
                          name += place.locality!;
                        }

                        if (place.administrativeArea != null) {
                          if (name.isNotEmpty) {
                            name += ", ";
                          }
                          name += place.administrativeArea!;
                        }

                        if (place.country != null) {
                          if (name.isNotEmpty) {
                            name += ", ";
                          }
                          name += place.country!;
                        }

                        if (place.postalCode != null) {
                          if (name.isNotEmpty) {
                            name += " ";
                          }
                          name += place.postalCode!;
                        }
                      }

                      IMLocation location = IMLocation(
                          address: name,
                          latitude: currentLatLng.latitude,
                          longitude: currentLatLng.longitude);
                      Navigator.pop(context, location);
                    },
                    child: const Center(
                        child: Text(
                      "分享",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal),
                    )))),
          ],
        ),
        body: Stack(children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              onTap: (tapPos, latLng) {
                currentLatLng = latLng;
                final pt1 = _mapController.latLngToScreenPoint(latLng);
                _textPos = CustomPoint(pt1!.x, pt1.y);
                setState(() {});
              },
              center: LatLng(51.5, -0.09),
              zoom: 11,
              rotation: 0,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
                userAgentPackageName: 'dev.fleaflet.flutter_map.example',
              ),
            ],
          ),
          Positioned(
              left: _textPos.x.toDouble(),
              top: _textPos.y.toDouble(),
              width: 20,
              height: 20,
              child: Assets.images.locationMark.image(
                  package:
                      IMKit.instance.internal.state.sdkDefaultPackageName)),
          Container(
            padding: const EdgeInsets.all(14),
            child: CurrentLocation(
                mapController: _mapController,
                callback: (currentLocation) {
                  currentLatLng = LatLng(
                      currentLocation.latitude!, currentLocation.longitude!);
                }),
          )
        ]));
  }
}

typedef CurrentLocationCallback = void Function(LocationData data);

class CurrentLocation extends StatefulWidget {
  const CurrentLocation({
    Key? key,
    required this.mapController,
    required this.callback,
  }) : super(key: key);

  final MapController mapController;
  final CurrentLocationCallback callback;

  @override
  _CurrentLocationState createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  int _eventKey = 0;

  // IconData icon = Icons.gps_not_fixed;
  late final StreamSubscription<MapEvent> mapEventSubscription;

  @override
  void initState() {
    super.initState();
    mapEventSubscription =
        widget.mapController.mapEventStream.listen(onMapEvent);
  }

  @override
  void dispose() {
    mapEventSubscription.cancel();
    super.dispose();
  }

  // void setIcon(IconData newIcon) {
  //   if (newIcon != icon && mounted) {
  //     setState(() {
  //       icon = newIcon;
  //     });
  //   }
  // }

  void onMapEvent(MapEvent mapEvent) {
    if (mapEvent is MapEventMove && mapEvent.id != _eventKey.toString()) {
      // setIcon(Icons.gps_not_fixed);
    }
  }

  void _moveToCurrent() async {
    _eventKey++;
    final location = Location();

    try {
      final currentLocation = await location.getLocation();
      final moved = widget.mapController.move(
        LatLng(currentLocation.latitude!, currentLocation.longitude!),
        18,
        id: _eventKey.toString(),
      );

      // setIcon(moved ? Icons.gps_fixed : Icons.gps_not_fixed);
      widget.callback(currentLocation);
    } catch (e) {
      // setIcon(Icons.gps_off);
    }
  }

  @override
  Widget build(BuildContext context) {
    // return IconButton(
    //   icon: Icon(icon),
    //   color: IMKit.style.inputBar.iconColor,
    //   onPressed: _moveToCurrent,
    // );
    return InkWell(
        onTap: () => _moveToCurrent(),
        child: Assets.images.locationLocate.image(
            package: IMKit.instance.internal.state.sdkDefaultPackageName));
  }
}
