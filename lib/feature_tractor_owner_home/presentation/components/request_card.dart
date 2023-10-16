import 'package:flutter/material.dart';
import 'package:my_tractor/core/domain/model/user_model.dart';
import 'package:my_tractor/core/presentation/controller/auth_controller.dart';
import 'package:get/get.dart';

class RequestCard extends StatefulWidget {
  final String uid;
  final bool isPending;

  const RequestCard({super.key, required this.uid, required this.isPending});

  @override
  State<RequestCard> createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
  late final AuthController _authController;

  @override
  void initState() {
    super.initState();

    _authController = Get.find<AuthController>();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _authController.listenToUserData(uid: widget.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return UnconstrainedBox(
              child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor),
            );
          }

          if (snapshot.data == null) {
            return const Center(child: Text("No Data found!"));
          }

          final user =
              UserModel.fromJson(snapshot.data!.data() as Map<String, dynamic>);

          return Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).scaffoldBackgroundColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.1)),
                      child: Center(
                        child: Text(user.fullName![0],
                            style: Theme.of(context).textTheme.titleMedium),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.fullName!,
                            style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 8),
                        Text(user.phoneNumber!,
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: widget.isPending
                      ? [
                          GestureDetector(
                            onTap: () async {
                              //  add the request to list of request for the tractor owner
                              final tractorOwnerDetails =
                                  await _authController.getSpecificUserFromFirestore();

                              final tractorAcceptedRequests = [...tractorOwnerDetails.acceptedRequests!];
                              final tractorRequests = [...tractorOwnerDetails.requests!];

                              if (!tractorAcceptedRequests.contains(widget.uid)) {
                                tractorAcceptedRequests.add(widget.uid);
                                tractorRequests.removeWhere((id) => id == widget.uid);
                              }

                              await _authController.updateUserData(
                                  newUser: tractorOwnerDetails.copyWith(
                                      acceptedRequests: tractorAcceptedRequests));
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.1),
                              ),
                              child: Icon(Icons.done_rounded,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () async {
                              //  delete the request to list of request for the tractor owner
                              final tractorOwnerDetails =
                                  await _authController.getSpecificUserFromFirestore();

                              final tractorRequests = [...tractorOwnerDetails.requests!];

                              if (tractorRequests.contains(widget.uid)) {
                                tractorRequests.removeWhere((id) => id == widget.uid);
                              }

                              await _authController.updateUserData(
                                  newUser: tractorOwnerDetails.copyWith(
                                      requests: tractorRequests));
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.redAccent.withOpacity(0.1),
                              ),
                              child: const Icon(Icons.cancel_outlined,
                                  color: Colors.redAccent),
                            ),
                          )
                        ]
                      : [
                          Text(
                            "Approved",
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                        ],
                )
              ],
            ),
          );
        });
  }
}
