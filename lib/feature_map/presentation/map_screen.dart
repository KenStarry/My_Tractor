import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

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

  Future<LocationData> getCurrentLocation() async {
    Location location = Location();

    return location.getLocation();
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
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: FutureBuilder(
          future: getCurrentLocation(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.data == null) {
              return const Center(child: Text("Loading..."));
            }

            return Stack(
              children: [
                GoogleMap(
                    initialCameraPosition:
                    const CameraPosition(target: sourceLocation, zoom: 13.0),
                    polylines: {
                      Polyline(
                          polylineId: const PolylineId("route"),
                          points: polylineCoordinates,
                          color: Theme.of(context).primaryColor,
                          width: 5)
                    },
                    markers: {
                      const Marker(
                          markerId: MarkerId("source"), position: sourceLocation),
                      const Marker(
                          markerId: MarkerId("destination"), position: destination),
                    })
              ],
            );
          }),
    );
  }
}
