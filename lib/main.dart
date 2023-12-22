import 'package:flutter/material.dart';
import 'package:lueesa_app/app/routing/app_route.dart';
import 'package:lueesa_app/ui/style/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/app_setup.locator.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
