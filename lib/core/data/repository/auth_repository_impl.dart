import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_tractor/core/domain/model/response_state.dart';
import 'package:my_tractor/core/domain/model/user_model.dart';
import 'package:my_tractor/core/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {

  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  @override
  Future<bool> checkUserExists({required String uid}) {
    // TODO: implement checkUserExists
    throw UnimplementedError();
  }

  @override
  Future<void> createAccount({required String email, required String password, required Function(ResponseState response, String? error) response}) {
    // TODO: implement createAccount
    throw UnimplementedError();
  }

  @override
  Future<UserModel> getSpecificUserFromFirestore({required String uid}) {
    // TODO: implement getSpecificUserFromFirestore
    throw UnimplementedError();
  }

  @override
  Stream<DocumentSnapshot<Object?>> getUserDataFromFirestore() {
    // TODO: implement getUserDataFromFirestore
    throw UnimplementedError();
  }

  @override
  Future<void> saveUserDataToFirestore({required UserModel userModel, required Function(ResponseState response, String? error) response, required Function onSuccess}) {
    // TODO: implement saveUserDataToFirestore
    throw UnimplementedError();
  }

  @override
  Future<void> signIn({required String email, required String password, required Function(ResponseState response, String? error) response}) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<void> updateUserDataInFirestore({required UserModel oldUser, required UserModel newUser, required String uid, Function(ResponseState response, String? error)? response}) {
    // TODO: implement updateUserDataInFirestore
    throw UnimplementedError();
  }

  
}