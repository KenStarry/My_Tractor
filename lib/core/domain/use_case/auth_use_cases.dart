import 'package:my_tractor/core/domain/use_case/create_account.dart';

import 'auth_state.dart';

class AuthUseCases {
  final CreateAccount createAccount;
  final AuthState authState;

  AuthUseCases({required this.createAccount, required this.authState});
}
