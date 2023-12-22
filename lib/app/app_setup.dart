import 'package:lueesa_app/core/services/auth_service.dart';
import 'package:lueesa_app/core/services/user_service.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(routes: [], dependencies: [
  LazySingleton(classType: AuthService),
  LazySingleton(classType: UserService)
])
class AppSetup {}
