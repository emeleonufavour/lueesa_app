import 'package:lueesa_app/core/services/auth_service.dart';
import 'package:lueesa_app/core/services/storage_service.dart';
import 'package:lueesa_app/core/services/user_service.dart';
import 'package:stacked/stacked_annotations.dart';

import '../ui/views/auth/login/login_view.dart';
import '../ui/views/home/home.dart';
import '../ui/views/pq_upload/pq_upload_screen.dart';
import '../ui/views/splash_screen/splash_view.dart';

@StackedApp(routes: [
  AdaptiveRoute(page: SplashScreenView),
  AdaptiveRoute(page: LoginView),
  AdaptiveRoute(page: HomeView),
  AdaptiveRoute(page: PastQuestionUploadScreen),
], dependencies: [
  LazySingleton(classType: AuthService),
  LazySingleton(classType: UserService),
  LazySingleton(classType: StorageService),
])
class AppSetup {}
