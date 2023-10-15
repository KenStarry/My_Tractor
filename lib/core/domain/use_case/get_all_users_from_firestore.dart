import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../di/locator.dart';
import '../repository/auth_repository.dart';

class GetAllUsersFromFirestore {
  final repo = locator.get<AuthRepository>();

  Stream<QuerySnapshot<Map<String, dynamic>>> call() => repo.getAllUsersFromFirestore();
}
