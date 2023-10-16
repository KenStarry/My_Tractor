import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_tractor/core/domain/repository/auth_repository.dart';
import 'package:my_tractor/di/locator.dart';

class ListenToUserData {
  final repo = locator.get<AuthRepository>();

  Stream<DocumentSnapshot> call({String? uid}) =>
      repo.listenToUserData(uid: uid);
}
