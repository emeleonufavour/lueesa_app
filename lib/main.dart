import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lueesa_app/app/routing/app_route.dart';
import 'package:lueesa_app/core/services/user_service.dart';
import 'package:lueesa_app/ui/style/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lueesa_app/ui/views/home/home.dart';
import 'package:lueesa_app/ui/views/splash_screen/splash_view.dart';
import 'package:lueesa_app/ui/views/test.dart';
import 'package:stacked_services/stacked_services.dart';
import 'app/app_setup.locator.dart';
import 'app/app_setup.router.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(DevicePreview(
      enabled: !kReleaseMode, builder: (context) => const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        theme: AppTheme.lightTheme,
        navigatorKey: StackedService.navigatorKey,
        onGenerateRoute: StackedRouter().onGenerateRoute,
        home: const SplashScreenView());
  }
}
