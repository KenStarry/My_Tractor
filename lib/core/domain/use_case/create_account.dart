import 'package:my_tractor/core/domain/repository/auth_repository.dart';
import 'package:my_tractor/di/locator.dart';

import '../model/response_state.dart';
import '../model/user_model.dart';

class CreateAccount {
  final repo = locator.get<AuthRepository>();

  Future<void> call({
    required UserModel userModel,
    required String password,
    required Function(ResponseState response, String? error) response,
  }) async =>
      repo.createAccount(
          userModel: userModel, password: password, response: response);
}
