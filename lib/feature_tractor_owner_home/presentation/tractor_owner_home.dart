import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_tractor/core/presentation/controller/auth_controller.dart';
import 'package:my_tractor/feature_tractor_owner_home/presentation/components/request_card.dart';

class TractorOwnerHome extends StatefulWidget {
  const TractorOwnerHome({super.key});

  @override
  State<TractorOwnerHome> createState() => _TractorOwnerHomeState();
}

class _TractorOwnerHomeState extends State<TractorOwnerHome> {
  late final AuthController _authController;

  @override
  void initState() {
    super.initState();

    _authController = Get.find<AuthController>();
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    //  get current device position
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _authController.getSpecificUserFromFirestore(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                width: double.infinity,
                height: double.infinity,
                child: Center(
                    child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor)));
          }

          if (snapshot.data == null) {
            return const Center(child: Text("No Data found!"));
          }

          final user = snapshot.data!;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _authController.setUserModel(user: user);
          });

          return Scaffold(
            appBar: AppBar(
              title: Text("Requests",
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
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () async {
                  //  send live location to database
                  await _authController.updateUserData(
                      newUser:
                          user.copyWith(latitude: 180.05, longitude: 190.5),
                      uid: user.uid!);
                },
                backgroundColor:
                    Theme.of(context).primaryColorDark.withOpacity(0.7),
                label: Row(
                  children: [
                    Icon(Icons.location_on_rounded,
                        color: Theme.of(context).primaryColor),
                    const SizedBox(width: 8),
                    Text("Ping Location",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .fontWeight,
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .fontSize))
                  ],
                )),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Accepted",
                        style: Theme.of(context).textTheme.titleMedium),
                    Expanded(
                      child: user.acceptedRequests!.isEmpty
                          ? const Center(
                              child: Text("No requests accepted yet"),
                            )
                          : ListView.separated(
                              itemBuilder: (context, index) => RequestCard(
                                  uid: user.acceptedRequests![index], isPending: false),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 8),
                              itemCount: user.acceptedRequests!.length),
                    ),
                    Text("Pending",
                        style: Theme.of(context).textTheme.titleMedium),
                    Expanded(
                      child: user.requests!.isEmpty ? const Center(
                        child: Text("No pending requests"),
                      ) : ListView.separated(
                          itemBuilder: (context, index) =>
                              RequestCard(uid: user.requests![index], isPending: true,),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 8),
                          itemCount: user.requests!.length),
                    ),
                  ],
                ),
              ),
            )),
          );
        });
  }
}
