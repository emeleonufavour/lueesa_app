import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lueesa_app/ui/style/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lueesa_app/ui/views/splash_screen/splash_view.dart';

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

  //log("Height => $height and Width => $width");
  runApp(const MainApp());
  // runApp(DevicePreview(
  //     enabled: !kReleaseMode, builder: (context) => const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: ScreenUtilInit(
        splitScreenMode: true,
        minTextAdapt: true,
        designSize: const Size(412, 890),
        builder: (context, child) => MaterialApp(
            // useInheritedMediaQuery: true,
            // locale: DevicePreview.locale(context),
            // builder: DevicePreview.appBuilder,
            theme: AppTheme.lightTheme,
            navigatorKey: StackedService.navigatorKey,
            onGenerateRoute: StackedRouter().onGenerateRoute,
            home: const SplashScreenView()),
      ),
    );
  }
}
//  Height => 2337.0 and Width => 1080.0
// Height ==> 890.2857142857143 and Width ==> 411.42857142857144