import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_tractor/di/controller_di.dart';
import 'package:my_tractor/di/locator.dart';
import 'package:my_tractor/feature_login/presentation/components/login.dart';
import 'package:my_tractor/feature_sign_up/presentation/components/sign_up.dart';
import 'package:my_tractor/firebase_options.dart';
import 'package:my_tractor/theme/my_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  invokeDI();
  invokeControllers();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const SignUp(),
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.lightTheme,
    );
  }
}
