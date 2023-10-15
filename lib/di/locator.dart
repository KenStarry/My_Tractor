import 'package:get_it/get_it.dart';
import 'package:my_tractor/core/data/repository/auth_repository_impl.dart';
import 'package:my_tractor/core/domain/repository/auth_repository.dart';
import 'package:my_tractor/core/domain/use_case/auth_state.dart';
import 'package:my_tractor/core/domain/use_case/auth_use_cases.dart';
import 'package:my_tractor/core/domain/use_case/create_account.dart';
import 'package:my_tractor/core/domain/use_case/get_specific_user_from_firestore.dart';
import 'package:my_tractor/core/domain/use_case/sign_in.dart';
import 'package:my_tractor/core/domain/use_case/sign_out.dart';
import 'package:my_tractor/core/domain/use_case/update_user_data.dart';

import '../core/domain/use_case/get_all_users_from_firestore.dart';

final locator = GetIt.instance;

void invokeDI() {
  //  Auth Repository
  locator.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());

  //  Auth Use cases
  locator.registerLazySingleton<AuthUseCases>(() => AuthUseCases(
      createAccount: CreateAccount(),
      authState: AuthState(),
      signIn: SignIn(),
      signOut: SignOut(),
      getSpecificUserFromFirestore: GetSpecificUserFromFirestore(),
      updateUserData: UpdateUserData(),
      getAllUsersFromFirestore: GetAllUsersFromFirestore()));
}
