import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:my_tractor/core/domain/use_case/auth_use_cases.dart';
import 'package:my_tractor/di/locator.dart';

import '../../domain/model/response_state.dart';
import '../../domain/model/user_model.dart';

class AuthController extends GetxController {
  final selectedUserType = Rxn<String>();
  final authUseCase = locator.get<AuthUseCases>();

  final currentLocation = LatLng(0.0, 0.0).obs;
  final userModel = Rxn<UserModel>();
  final allTractors = <UserModel>{}.obs;
  final isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();

    authState().listen((user) {
      isLoggedIn.value = user != null;
    });

    getAllUsersFromFirestore().listen((snapshots) {
      final tractors = snapshots.docs
          .map(
              (snapshotDocument) => UserModel.fromJson(snapshotDocument.data()))
          .toList()
          .toSet();

      allTractors.value = tractors;
    });

    getCurrentLocation();
  }

  Future<Position> getCurrentLocation() async {
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

    final currentPosition = await Geolocator.getCurrentPosition();

    currentLocation.value =
        LatLng(currentPosition.latitude, currentPosition.longitude);

    await updateUserData(
        newUser: userModel.value!.copyWith(
            latitude: currentPosition.latitude,
            longitude: currentPosition.longitude),
        uid: userModel.value!.uid!);

    return currentPosition;
  }

  void setSelectedUserType({required String? userType}) =>
      selectedUserType.value = userType;

  void setUserModel({required UserModel? user}) => userModel.value = user;

  Future<void> createAccount({
    required UserModel userModel,
    required String password,
    required Function(ResponseState response, String? error) response,
  }) async =>
      await authUseCase.createAccount
          .call(userModel: userModel, password: password, response: response);

  Stream authState() => authUseCase.authState();

  Future<void> signIn({
    required String email,
    required String password,
    required Function(ResponseState response, String? error) response,
  }) async =>
      await authUseCase.signIn
          .call(email: email, password: password, response: response);

  Future<void> signOut() async => await authUseCase.signOut();

  Future<UserModel> getSpecificUserFromFirestore({String? uid}) async =>
      await authUseCase.getSpecificUserFromFirestore.call(uid: uid);

  Stream<DocumentSnapshot> listenToUserData({String? uid}) =>
      authUseCase.listenToUserData(uid: uid);

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsersFromFirestore() =>
      authUseCase.getAllUsersFromFirestore();

  Future<void> updateUserData(
          {required UserModel newUser,
          String? uid,
          Function(ResponseState response, String? error)? response}) async =>
      await authUseCase.updateUserData
          .call(newUser: newUser, uid: uid, response: response);
}
