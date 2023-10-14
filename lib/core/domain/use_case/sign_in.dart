import 'package:my_tractor/core/domain/repository/auth_repository.dart';
import 'package:my_tractor/di/locator.dart';

import '../model/response_state.dart';

class SignIn {
  final repo = locator.get<AuthRepository>();

  Future<void> call({
    required String email,
    required String password,
    required Function(ResponseState response, String? error) response,
  }) async =>
      await repo.signIn(email: email, password: password, response: response);
}
