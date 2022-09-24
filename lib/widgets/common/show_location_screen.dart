import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:imkit/sdk/imkit.dart';
import 'package:latlong2/latlong.dart';

class ShowLocationScreen extends StatefulWidget {
  final double latitude;
  final double longitude;

  const ShowLocationScreen(
      {Key? key, required this.latitude, required this.longitude})
      : super(key: key);

  @override
  State createState() {
    return _ShowLocationScreenState();
  }
}

class _ShowLocationScreenState extends State<ShowLocationScreen> {
  late final MapController _mapController;
  CustomPoint _textPos = const CustomPoint(10.0, 10.0);

  @override
  void initState() {
    super.initState();
    _mapController = MapController();

    Future.delayed(Duration.zero, () => _moveToMessageLocation());
  }

  _moveToMessageLocation() async {
    LatLng latLng = LatLng(widget.latitude, widget.longitude);
    _mapController.move(
      latLng,
      18,
    );
    final screenPoint = _mapController.latLngToScreenPoint(latLng);
    setState(() {
      _textPos = CustomPoint(screenPoint!.x, screenPoint.y);
    });
  }

  void onMapEvent(MapEvent mapEvent) {
    if (mapEvent is! MapEventMove && mapEvent is! MapEventRotate) {
      // do not flood console with move and rotate events
      debugPrint(mapEvent.toString());

      LatLng latLng = LatLng(widget.latitude, widget.longitude);
      final screenPoint = _mapController.latLngToScreenPoint(latLng);
      _textPos = CustomPoint(screenPoint!.x, screenPoint.y);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          onTap: (tapPos, latLng) {},
          center: LatLng(widget.latitude, widget.longitude),
          interactiveFlags: InteractiveFlag.pinchZoom,
          zoom: 11,
          rotation: 0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
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
          child:
              Icon(Icons.location_pin, color: IMKit.style.inputBar.iconColor))
    ]));
  }
}
