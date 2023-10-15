import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:my_tractor/core/domain/use_case/auth_use_cases.dart';
import 'package:my_tractor/di/locator.dart';

import '../../domain/model/response_state.dart';
import '../../domain/model/user_model.dart';

class AuthController extends GetxController {
  final selectedUserType = Rxn<String>();
  final authUseCase = locator.get<AuthUseCases>();

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
          .toList().toSet();

      allTractors.value = tractors;
    });
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

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsersFromFirestore() =>
      authUseCase.getAllUsersFromFirestore();

  Future<void> updateUserData(
          {required UserModel newUser,
          required String uid,
          Function(ResponseState response, String? error)? response}) async =>
      await authUseCase.updateUserData
          .call(newUser: newUser, uid: uid, response: response);
}
