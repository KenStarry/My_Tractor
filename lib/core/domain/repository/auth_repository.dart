import 'package:firebase_auth/firebase_auth.dart';

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

  /// Auth State
  Stream authState();

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

  /// Get User Data From Firebase
  Future<UserModel> getSpecificUserFromFirestore({String? uid});

  /// Listen to User Document updates
  Stream<DocumentSnapshot> listenToUserData({String? uid});

  /// Get All Users From Firestore
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsersFromFirestore();

  /// Update User Data In Firestore
  Future<void> updateUserDataInFirestore(
      {required UserModel newUser,
      required String uid,
      Function(ResponseState response, String? error)? response});
}
