import 'package:get/get.dart';

class AuthController extends GetxController {
  final selectedUserType = Rxn<String>();

  void setSelectedUserType({required String? userType}) =>
      selectedUserType.value = userType;
}
