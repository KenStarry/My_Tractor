import 'package:get/get.dart';
import 'package:my_tractor/core/domain/use_case/auth_use_cases.dart';
import 'package:my_tractor/di/locator.dart';

import '../../domain/model/response_state.dart';
import '../../domain/model/user_model.dart';

class AuthController extends GetxController {
  final selectedUserType = Rxn<String>();
  final authUseCase = locator.get<AuthUseCases>();

  final userModel = Rxn<UserModel>();
  final isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();

    authState().listen((user) {
      isLoggedIn.value = user != null;
    });
  }

  void setSelectedUserType({required String? userType}) =>
      selectedUserType.value = userType;

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
}
