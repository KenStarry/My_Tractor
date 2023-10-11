import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_tractor/feature_map/presentation/map_screen.dart';
import 'package:my_tractor/theme/my_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const MapScreen(),
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.lightTheme,
    );
  }
}

