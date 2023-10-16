import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_tractor/core/presentation/components/show_toast.dart';

import '../../../core/presentation/controller/auth_controller.dart';

class MyInfoWindow extends StatefulWidget {
  final String tractorOwnerId;
  final String currentUserId;
  final FToast toast;

  const MyInfoWindow(
      {super.key, required this.toast, required this.tractorOwnerId, required this.currentUserId});

  @override
  State<MyInfoWindow> createState() => _MyInfoWindowState();
}

class _MyInfoWindowState extends State<MyInfoWindow> {
  late final AuthController _authController;

  @override
  void initState() {
    super.initState();

    _authController = Get.find<AuthController>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 150,
          height: 150,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/images/tractor.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    )),
              ),
              Text("Starry", style: Theme.of(context).textTheme.bodyLarge),
              TextButton(
                  onPressed: () async {
                    //  add the request to list of request for the tractor owner
                    final tractorOwnerDetails =
                        await _authController.getSpecificUserFromFirestore(
                            uid: widget.tractorOwnerId);

                    final tractorRequests = [...tractorOwnerDetails.requests!];

                    if (!tractorRequests.contains(widget.currentUserId)) {
                      tractorRequests.add(widget.currentUserId);

                      await _authController
                          .updateUserData(
                          newUser: tractorOwnerDetails.copyWith(
                              requests: tractorRequests),
                          uid: widget.tractorOwnerId)
                          .then((value) {
                        showToast(
                            toast: widget.toast,
                            iconData: Icons.access_time,
                            msg: 'Request Sent to driver!');
                      });
                    } else {
                      showToast(
                          toast: widget.toast,
                          iconData: Icons.done,
                          msg: 'Request already sent, pending approval.');
                    }
                  },
                  style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColorDark,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor),
                  child: Text(
                    "Hire Tractor",
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.bodyMedium!.fontSize,
                        fontWeight:
                            Theme.of(context).textTheme.bodyMedium!.fontWeight,
                        color: Theme.of(context).primaryColorDark),
                  ))
            ],
          ),
        ),
        ClipPath(
          clipper: TriangleClipper(),
          child: Container(
            width: 20,
            height: 20,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        )
      ],
    );
  }
}
