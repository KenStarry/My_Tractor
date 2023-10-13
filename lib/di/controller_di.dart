import 'package:get/get.dart';
import 'package:my_tractor/core/presentation/controller/auth_controller.dart';

void invokeControllers() {
  Get.lazyPut(() => AuthController(), fenix: true);
}
