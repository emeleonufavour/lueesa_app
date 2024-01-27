import 'package:lueesa_app/core/services/auth_service.dart';
import 'package:lueesa_app/core/services/storage_service.dart';
import 'package:lueesa_app/core/services/user_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../ui/views/auth/login/login_view.dart';
import '../ui/views/executives/execs_view.dart';
import '../ui/views/home/home.dart';
import '../ui/views/note_upload/note_upload_screen.dart';
import '../ui/views/notes_view/notes_view.dart';
import '../ui/views/pq_upload/pq_upload_screen.dart';
import '../ui/views/pq_view/pq_view_screen.dart';
import '../ui/views/splash_screen/splash_view.dart';
import '../ui/views/time_table/bottom_sheet/add_course_bm.dart';
import '../ui/views/time_table/time_table_view.dart';

@StackedApp(routes: [
  AdaptiveRoute(page: SplashScreenView, initial: true),
  AdaptiveRoute(page: LoginView),
  AdaptiveRoute(page: HomeView),
  AdaptiveRoute(page: PastQuestionUploadScreen),
  AdaptiveRoute(page: PQViewScreen),
  AdaptiveRoute(page: TimeTableView),
  AdaptiveRoute(page: AddCourseView),
  AdaptiveRoute(page: NotesUploadScreen),
  AdaptiveRoute(page: NotesView),
  AdaptiveRoute(page: ExecsView)
], dependencies: [
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: AuthService),
  LazySingleton(classType: UserService),
  LazySingleton(classType: StorageService),
])
class AppSetup {}
