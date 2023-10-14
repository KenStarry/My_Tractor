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
  Future<void> createAccount(
      {required UserModel userModel,
      required String password,
      required Function(ResponseState response, String? error)
          response}) async {
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: userModel.email!, password: password)
          .then((value) async {
        //  get the UID
        final uid = auth.currentUser!.uid;
        final newUserModel = userModel.copyWith(uid: uid);

        //  create account in firestore
        await _saveUserDataToFirestore(
            userModel: newUserModel, response: response, onSuccess: () {});
      });
    } on FirebaseException catch (error) {
      response(ResponseState.failure, error.message);
    }
  }

  @override
  Stream authState() => auth.authStateChanges();

  @override
  Future<UserModel> getSpecificUserFromFirestore({String? uid}) async {
    try {
      final snapshot = await firestore
          .collection('Users')
          .doc(uid ?? auth.currentUser!.uid)
          .get();

      return UserModel.fromJson(snapshot.data()!);
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> _saveUserDataToFirestore(
      {required UserModel userModel,
      required Function(ResponseState response, String? error) response,
      required Function onSuccess}) async {
    response(ResponseState.loading, null);
    try {
      await firestore
          .collection('Users')
          .doc(auth.currentUser!.uid)
          .set(userModel.toJson())
          .then((value) {
        response(ResponseState.success, null);
      });
    } on FirebaseException catch (error) {
      response(ResponseState.failure, error.message);
    }
  }

  @override
  Future<void> signIn(
      {required String email,
      required String password,
      required Function(ResponseState response, String? error)
          response}) async {
    response(ResponseState.loading, null);
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        response(ResponseState.success, null);
      });
    } on FirebaseException catch (error) {
      response(ResponseState.failure, error.message);
    }
  }

  @override
  Future<void> signOut() async => await auth.signOut();

  @override
  Future<void> updateUserDataInFirestore(
      {required UserModel newUser,
      required String uid,
      Function(ResponseState response, String? error)? response}) async {
    try {
      await firestore
          .collection('Users')
          .doc(uid)
          .set(newUser.toJson())
          .then((value) {
        response!(ResponseState.success, null);
      });
    } catch (error) {
      throw Exception(error);
    }
  }
}
