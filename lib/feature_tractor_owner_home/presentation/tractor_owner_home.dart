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
    return Obx(
      () => _authController.userModel.value == null
          ? FutureBuilder(
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
                            newUser: user.copyWith(latitude: 180.05),
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
                      child: ListView.separated(
                          itemBuilder: (context, index) => const RequestCard(),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 24),
                          itemCount: 20),
                    ),
                  )),
                );
              })
          : Scaffold(
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
                        newUser: _authController.userModel.value!
                            .copyWith(latitude: 90.05),
                        uid: _authController.userModel.value!.uid!);
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
                  child: ListView.separated(
                      itemBuilder: (context, index) => const RequestCard(),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 24),
                      itemCount: 20),
                ),
              )),
            ),
    );
  }
}
