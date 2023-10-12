import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class MyTheme {
  /// Light Theme
  static ThemeData get lightTheme => ThemeData(
      primaryColor: accent,
      primaryColorDark: secondary,
      scaffoldBackgroundColor: white,
      fontFamily: 'DMSans',
      textTheme: const TextTheme(
        bodySmall: TextStyle(
            fontSize: 11, fontWeight: FontWeight.w500, color: textBlack500),
        bodyMedium: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w500, color: textBlack500),
        bodyLarge: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: textBlack700),
        titleSmall: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w700, color: textPrimary),
        titleMedium: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: textPrimary),
        titleLarge: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: textPrimary),
      ));
}
