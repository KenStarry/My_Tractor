import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_tractor/feature_map/presentation/map_screen.dart';
import 'package:my_tractor/feature_tractor_owner_home/presentation/tractor_owner_home.dart';

import 'controller/auth_controller.dart';

class DashboardSeparator extends StatefulWidget {
  const DashboardSeparator({super.key});

  @override
  State<DashboardSeparator> createState() => _DashboardSeparatorState();
}

class _DashboardSeparatorState extends State<DashboardSeparator> {
  late final AuthController _authController;

  @override
  void initState() {
    super.initState();

    _authController = Get.find<AuthController>();
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
            return Center(child: const Text("No Data found!"));
          }

          final user = snapshot.data!;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _authController.setUserModel(user: user);
          });

          return user.userType! == 'Publish'
              ? const TractorOwnerHome()
              : const MapScreen();
        });
  }
}
