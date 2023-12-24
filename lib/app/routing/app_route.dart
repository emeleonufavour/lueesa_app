import 'package:go_router/go_router.dart';
import 'package:lueesa_app/app/routing/screen_path.dart';
import 'package:lueesa_app/ui/views/home/home.dart';
import 'package:lueesa_app/ui/views/splash_screen/splash_view.dart';

import '../../core/services/user_service.dart';
import '../../ui/views/auth/login/login_view.dart';
import '../../ui/views/pq_upload/pq_upload_screen.dart';
import '../app_setup.locator.dart';

final _userService = locator<UserService>();

class AppRoute {
  AppRoute._();

  static final AppRoute _router = AppRoute._();

  factory AppRoute.instance() {
    return _router;
  }

  final routes = GoRouter(
      initialLocation: ScreenPath.splashScreen,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
            path: ScreenPath.splashScreen,
            builder: ((context, state) => const SplashScreenView())),
        GoRoute(
          path: ScreenPath.login,
          builder: (context, state) => const LoginView(),
        ),
        GoRoute(
          path: ScreenPath.home,
          builder: ((context, state) => const HomeView()),
        ),
        GoRoute(
          path: ScreenPath.pastquestion,
          builder: (context, state) => const PastQuestionUploadScreen(),
        )
      ]);
}
