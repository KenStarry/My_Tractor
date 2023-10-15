import '../../../di/locator.dart';
import '../repository/auth_repository.dart';

class GetAllUsersFromFirestore {
  final repo = locator.get<AuthRepository>();

  Stream call() => repo.getAllUsersFromFirestore();
}
