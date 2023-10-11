import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  late final GoogleMapController googleMapController;

  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);

  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation = null;

  @override
  void initState() {
    super.initState();

    _mapController = Completer();
    getPolylinePoints();
    setCustomMarkerIcon();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void setCustomMarkerIcon() async {
    final Uint8List icon =
        await getBytesFromAsset("assets/images/tractor.png", 120);
    markerIcon = BitmapDescriptor.fromBytes(icon);
  }

  void completeMap() async {
    googleMapController = await _mapController.future;
  }

  Stream<LocationData> getCurrentLocation() {
    Location location = Location();

    return location.onLocationChanged;
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
      body: StreamBuilder(
          stream: getCurrentLocation(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.data == null) {
              return const Center(child: Text("Loading..."));
            }

            final currentLocation = snapshot.data!;

            // googleMapController.animateCamera(CameraUpdate.newCameraPosition(
            //     CameraPosition(
            //         zoom: 13.0,
            //         target: LatLng(
            //             currentLocation.latitude!,
            //             currentLocation.longitude!))));

            return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: LatLng(currentLocation.latitude!,
                          currentLocation.longitude!),
                      zoom: 13.0),
                  polylines: {
                    Polyline(
                        polylineId: const PolylineId("route"),
                        points: polylineCoordinates,
                        color: Theme.of(context).primaryColor,
                        width: 5)
                  },
                  markers: {
                    Marker(
                        markerId: const MarkerId("currentLocation"),
                        icon: markerIcon,
                        position: LatLng(currentLocation.latitude!,
                            currentLocation.longitude!)),
                    Marker(
                        markerId: const MarkerId("source"),
                        icon: markerIcon,
                        position: sourceLocation),
                    Marker(
                        markerId: const MarkerId("destination"),
                        icon: markerIcon,
                        position: destination),
                  },
                  onMapCreated: (controller) {
                    _mapController.complete(controller);
                  },
                )
              ],
            );
          }),
    );
  }
}
