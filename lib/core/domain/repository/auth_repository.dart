import '../model/response_state.dart';
import '../model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AuthRepository {

  /// Create Account
  Future<void> createAccount({
    required UserModel userModel,
    required String password,
    required Function(ResponseState response, String? error) response,
  });

  /// Sign In
  Future<void> signIn({
    required String email,
    required String password,
    required Function(ResponseState response, String? error) response,
  });

  /// Sign Out
  Future<void> signOut();

  /// Check if User Exists
  Future<bool> checkUserExists({required String uid});

  /// Save User to Firestore
  Future<void> saveUserDataToFirestore(
      {required UserModel userModel,
      required Function(ResponseState response, String? error) response,
      required Function onSuccess});

  /// Get User Data From Firebase
  Stream<DocumentSnapshot> getUserDataFromFirestore();

  /// Get User Data From Firebase
  Future<UserModel> getSpecificUserFromFirestore({required String uid});

  /// Update User Data In Firestore
  Future<void> updateUserDataInFirestore(
      {required UserModel oldUser,
      required UserModel newUser,
      required String uid,
      Function(ResponseState response, String? error)? response});
}
