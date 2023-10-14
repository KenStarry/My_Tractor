import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_tractor/core/presentation/controller/auth_controller.dart';
import 'package:my_tractor/core/presentation/dashboard_separator.dart';
import 'package:my_tractor/di/controller_di.dart';
import 'package:my_tractor/di/locator.dart';
import 'package:my_tractor/feature_login/presentation/components/login.dart';
import 'package:my_tractor/feature_sign_up/presentation/components/sign_up.dart';
import 'package:my_tractor/feature_tractor_owner_home/presentation/tractor_owner_home.dart';
import 'package:my_tractor/firebase_options.dart';
import 'package:my_tractor/theme/my_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  invokeDI();
  invokeControllers();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AuthController _authController;

  @override
  void initState() {
    super.initState();

    _authController = Get.find<AuthController>();

    ever(_authController.isLoggedIn, (isLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!isLoggedIn) {
          Get.offAll(() => const Login());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        home: _authController.isLoggedIn.value
            ? const DashboardSeparator()
            : const Login(),
        debugShowCheckedModeBanner: false,
        theme: MyTheme.lightTheme,
        darkTheme: MyTheme.lightTheme,
      ),
    );
  }
}
