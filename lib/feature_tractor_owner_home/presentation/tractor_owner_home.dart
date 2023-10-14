import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Requests", style: Theme.of(context).textTheme.titleMedium),
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
          onPressed: () {
            //  send live location to database
          },
          backgroundColor: Theme.of(context).primaryColorDark.withOpacity(0.7),
          label: Row(
            children: [
              Icon(Icons.location_on_rounded,
                  color: Theme.of(context).primaryColor),
              const SizedBox(width: 8),
              Text("Ping Location",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight:
                          Theme.of(context).textTheme.bodyMedium!.fontWeight,
                      fontSize:
                          Theme.of(context).textTheme.bodyMedium!.fontSize))
            ],
          )),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: ListView.separated(
              itemBuilder: (context, index) => const RequestCard(),
              separatorBuilder: (context, index) => const SizedBox(height: 24),
              itemCount: 20),
        ),
      )),
    );
  }
}
