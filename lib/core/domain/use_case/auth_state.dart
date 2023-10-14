import 'package:my_tractor/core/domain/repository/auth_repository.dart';
import 'package:my_tractor/di/locator.dart';

class AuthState {
  final repo = locator.get<AuthRepository>();

  Stream call() => repo.authState();
}
