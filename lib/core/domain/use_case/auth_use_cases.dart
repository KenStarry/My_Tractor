import 'package:my_tractor/core/domain/use_case/create_account.dart';
import 'package:my_tractor/core/domain/use_case/sign_in.dart';
import 'package:my_tractor/core/domain/use_case/sign_out.dart';
import 'package:my_tractor/core/domain/use_case/update_user_data.dart';

import 'auth_state.dart';
import 'get_specific_user_from_firestore.dart';

class AuthUseCases {
  final CreateAccount createAccount;
  final AuthState authState;
  final SignIn signIn;
  final SignOut signOut;
  final GetSpecificUserFromFirestore getSpecificUserFromFirestore;
  final UpdateUserData updateUserData;

  AuthUseCases(
      {required this.createAccount,
      required this.authState,
      required this.signIn,
      required this.signOut,
      required this.getSpecificUserFromFirestore,
      required this.updateUserData});
}
