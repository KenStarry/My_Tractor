import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:custom_info_window/custom_info_window.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../core/presentation/controller/auth_controller.dart';
import '../../core/util/constants.dart';
import 'components/hire_bottomsheet.dart';
import 'components/my_info_window.dart';
import 'components/tractor_card.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final Completer<GoogleMapController> _mapController;
  late final GoogleMapController googleMapController;
  late final CustomInfoWindowController _customInfoWindowController;
  late final AuthController _authController;
  late final FToast _toast;

  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);

  LocationData? currentUserLocation = null;

  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  List<LatLng> polylineCoordinates = [];

  @override
  void initState() {
    super.initState();

    _authController = Get.find<AuthController>();
    _customInfoWindowController = CustomInfoWindowController();

    _toast = FToast();
    _toast.init(context);

    _mapController = Completer();
    getPolylinePoints();
    setCustomMarkerIcon();
    completeMap();

    getCurrentLocation().listen((location) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          currentUserLocation = location;
        });
      });
    });
  }

  Stream<LocationData> getCurrentLocation() {
    Location location = Location();

    return location.onLocationChanged;
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
        appBar: AppBar(
          title: Text("Home",
              style: Theme.of(context).textTheme.titleMedium),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () async {
                  await _authController.signOut();
                },
                icon: Icon(
                  Icons.logout_rounded,
                  color: Theme.of(context).primaryColor,
                ))
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(32),
                      bottomLeft: Radius.circular(32)),
                  child: currentUserLocation == null
                      ? Center(
                          child: UnconstrainedBox(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                      : Obx(
                          () => Stack(
                            children: [
                              GoogleMap(
                                initialCameraPosition: CameraPosition(
                                    target: LatLng(
                                        currentUserLocation!.latitude!,
                                        currentUserLocation!.longitude!),
                                    zoom: 13.0),
                                onTap: (position) {
                                  _customInfoWindowController.hideInfoWindow!();
                                },
                                onCameraMove: (position) {
                                  _customInfoWindowController.onCameraMove!();
                                },
                                polylines: {
                                  Polyline(
                                      polylineId: const PolylineId("route"),
                                      points: polylineCoordinates,
                                      color: Theme.of(context).primaryColor,
                                      width: 5)
                                },
                                markers: _authController.allTractors
                                    .map((tractor) => Marker(
                                        markerId:
                                            const MarkerId("currentLocation"),
                                        icon: markerIcon,
                                        position: LatLng(tractor.latitude!,
                                            tractor.longitude!),
                                        onTap: () {
                                          _customInfoWindowController
                                                  .addInfoWindow!(
                                              MyInfoWindow(
                                                toast: _toast,
                                                tractorOwnerId: tractor.uid!,
                                                currentUserId: _authController
                                                    .userModel.value!.uid!,
                                              ),
                                              LatLng(tractor.latitude!,
                                                  tractor.longitude!));
                                        }))
                                    .toSet(),
                                onMapCreated: (controller) {
                                  _mapController.complete(controller);
                                  _customInfoWindowController
                                      .googleMapController = controller;
                                },
                              ),
                              CustomInfoWindow(
                                controller: _customInfoWindowController,
                                height: 180,
                                width: 180,
                                offset: 50,
                              )
                            ],
                          ),
                        ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 180,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(24),
                      topLeft: Radius.circular(24)),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: Column(
                  children: [
                    Text(
                      "Tractors",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Expanded(
                      child: Obx(
                        () => ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final tractor =
                                  _authController.allTractors.elementAt(index);
                              return TractorCard(
                                ownerName: tractor.fullName!,
                                onClick: () {
                                  googleMapController
                                      .animateCamera(CameraUpdate.newLatLng(
                                          LatLng(tractor.latitude!,
                                              tractor.longitude!)))
                                      .then((value) {
                                    _customInfoWindowController.addInfoWindow!(
                                        MyInfoWindow(
                                          toast: _toast,
                                          tractorOwnerId: tractor.uid!,
                                          currentUserId: _authController
                                              .userModel.value!.uid!,
                                        ),
                                        LatLng(tractor.latitude!,
                                            tractor.longitude!));
                                  });
                                },
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  width: 8,
                                ),
                            itemCount: _authController.allTractors.length),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
