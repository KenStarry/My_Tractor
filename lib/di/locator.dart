import 'package:get_it/get_it.dart';
import 'package:my_tractor/core/data/repository/auth_repository_impl.dart';
import 'package:my_tractor/core/domain/repository/auth_repository.dart';
import 'package:my_tractor/core/domain/use_case/auth_use_cases.dart';
import 'package:my_tractor/core/domain/use_case/create_account.dart';

final locator = GetIt.instance;

void invokeDI() {
  //  Auth Repository
  locator.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());

  //  Auth Use cases
  locator.registerLazySingleton<AuthUseCases>(
      () => AuthUseCases(createAccount: CreateAccount()));
}
