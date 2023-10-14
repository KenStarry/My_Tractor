import 'package:my_tractor/core/domain/use_case/create_account.dart';
import 'package:my_tractor/core/domain/use_case/sign_in.dart';
import 'package:my_tractor/core/domain/use_case/sign_out.dart';

import 'auth_state.dart';

class AuthUseCases {
  final CreateAccount createAccount;
  final AuthState authState;
  final SignIn signIn;
  final SignOut signOut;

  AuthUseCases(
      {required this.createAccount,
      required this.authState,
      required this.signIn,
      required this.signOut});
}
