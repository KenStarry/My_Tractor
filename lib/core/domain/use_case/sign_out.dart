import 'package:my_tractor/core/domain/repository/auth_repository.dart';
import 'package:my_tractor/di/locator.dart';

class SignOut {
  final repo = locator.get<AuthRepository>();

  Future<void> call() async => await repo.signOut();
}
