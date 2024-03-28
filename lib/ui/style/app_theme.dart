import 'package:flutter/material.dart';
import 'package:lueesa_app/ui/style/app_colors.dart';

class AppTheme {
  //Light theme
  static ThemeData get lightTheme {
    return ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        hintColor: AppColor.blue,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: AppColor.blue, foregroundColor: Colors.white),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black)),
        elevatedButtonTheme: const ElevatedButtonThemeData(),
        dialogTheme: DialogTheme(backgroundColor: Colors.white));
  }
}
