import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
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
        appBar: AppBar(title: const Text('LatLng To Screen Point')),
        // drawer: buildDrawer(context, LatLngScreenPointTestPage.route),
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child:
                // Container())
                FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                // onMapEvent: onMapEvent,
                onTap: (tapPos, latLng) {
                  print("latitude: ${latLng.latitude}");
                  print("longitude: ${latLng.longitude}");
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
          ),
          Positioned(
              left: _textPos.x.toDouble(),
              top: _textPos.y.toDouble(),
              width: 20,
              height: 20,
              child: const Icon(Icons.location_on)),
          CurrentLocation(mapController: _mapController),
        ]));
  }
}

class CurrentLocation extends StatefulWidget {
  const CurrentLocation({
    Key? key,
    required this.mapController,
  }) : super(key: key);

  final MapController mapController;

  @override
  _CurrentLocationState createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  int _eventKey = 0;

  IconData icon = Icons.gps_not_fixed;
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

  void setIcon(IconData newIcon) {
    if (newIcon != icon && mounted) {
      setState(() {
        icon = newIcon;
      });
    }
  }

  void onMapEvent(MapEvent mapEvent) {
    if (mapEvent is MapEventMove && mapEvent.id != _eventKey.toString()) {
      setIcon(Icons.gps_not_fixed);
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

      setIcon(moved ? Icons.gps_fixed : Icons.gps_not_fixed);
    } catch (e) {
      setIcon(Icons.gps_off);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      onPressed: _moveToCurrent,
    );
  }
}
