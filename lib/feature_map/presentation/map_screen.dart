import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/util/constants.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final Completer<GoogleMapController> _mapController;

  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);

  List<LatLng> polylineCoordinates = [];

  @override
  void initState() {
    super.initState();

    _mapController = Completer();
    getPolylinePoints();
  }

  //  get polyline points
  void getPolylinePoints() async {
    final polylinePoints = PolylinePoints();

    PolylineResult route = await polylinePoints.getRouteBetweenCoordinates(
        Constants.api_key,
        PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        PointLatLng(destination.latitude, destination.longitude));

    if (route.points.isNotEmpty) {
      for (var point in route.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        initialCameraPosition:
            const CameraPosition(target: sourceLocation, zoom: 13.0),
        markers: {
          const Marker(markerId: MarkerId("source"), position: sourceLocation),
          const Marker(
              markerId: MarkerId("destination"), position: destination),
        });
  }
}
