import 'package:my_tractor/core/domain/repository/auth_repository.dart';
import 'package:my_tractor/di/locator.dart';

import '../model/response_state.dart';
import '../model/user_model.dart';

class UpdateUserData {
  final repo = locator.get<AuthRepository>();

  Future<void> call(
          {required UserModel newUser,
          required String uid,
          Function(ResponseState response, String? error)? response}) async =>
      await repo.updateUserDataInFirestore(
          newUser: newUser, uid: uid, response: response);
}
