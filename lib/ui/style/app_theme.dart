import 'package:flutter/material.dart';
import 'package:lueesa_app/ui/style/app_colors.dart';

class AppTheme {
  //Light theme
  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      hintColor: AppColor.blue,
    );
  }
}
