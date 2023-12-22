import 'package:flutter/material.dart';
import 'package:lueesa_app/app/routing/app_route.dart';
import 'package:lueesa_app/ui/style/app_theme.dart';
import 'package:lueesa_app/ui/views/home/home.dart';
import 'package:lueesa_app/ui/views/splash_screen/splash_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppRoute appRoute = AppRoute.instance();
    return MaterialApp.router(
      theme: AppTheme.lightTheme,
      routerConfig: appRoute.routes,
    );
  }
}
