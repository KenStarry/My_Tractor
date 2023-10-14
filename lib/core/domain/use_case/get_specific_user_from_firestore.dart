import 'package:my_tractor/core/domain/repository/auth_repository.dart';
import 'package:my_tractor/di/locator.dart';

import '../model/user_model.dart';

class GetSpecificUserFromFirestore {
  final repo = locator.get<AuthRepository>();

  Future<UserModel> call({String? uid}) async =>
      await repo.getSpecificUserFromFirestore(uid: uid);
}
