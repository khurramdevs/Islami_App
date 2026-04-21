import 'package:flutter/material.dart';
import 'package:islami/const/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.black,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.gold,
      surface: AppColors.black,
    ),
    useMaterial3: true,
  );
}
