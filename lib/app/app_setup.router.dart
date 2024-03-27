// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i15;
import 'package:flutter/material.dart' as _i14;
import 'package:flutter/material.dart';
import 'package:lueesa_app/ui/views/auth/login/login_view.dart' as _i3;
import 'package:lueesa_app/ui/views/auth/vote_login/vote_login.dart' as _i12;
import 'package:lueesa_app/ui/views/executives/execs_view.dart' as _i11;
import 'package:lueesa_app/ui/views/home/home.dart' as _i4;
import 'package:lueesa_app/ui/views/note_upload/note_upload_screen.dart' as _i9;
import 'package:lueesa_app/ui/views/notes_view/notes_view.dart' as _i10;
import 'package:lueesa_app/ui/views/pq_upload/pq_upload_screen.dart' as _i5;
import 'package:lueesa_app/ui/views/pq_view/pq_view_screen.dart' as _i6;
import 'package:lueesa_app/ui/views/splash_screen/splash_view.dart' as _i2;
import 'package:lueesa_app/ui/views/time_table/bottom_sheet/add_course_bm.dart'
    as _i8;
import 'package:lueesa_app/ui/views/time_table/time_table_view.dart' as _i7;
import 'package:lueesa_app/ui/views/voting/voting_screen.dart' as _i13;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i16;

class Routes {
  static const splashScreenView = '/';

  static const loginView = '/login-view';

  static const homeView = '/home-view';

  static const pastQuestionUploadScreen = '/past-question-upload-screen';

  static const pQViewScreen = '/p-qview-screen';

  static const timeTableView = '/time-table-view';

  static const addCourseView = '/add-course-view';

  static const notesUploadScreen = '/notes-upload-screen';

  static const notesView = '/notes-view';

  static const execsView = '/execs-view';

  static const votingLoginScreen = '/voting-login-screen';

  static const votingScreen = '/voting-screen';

  static const all = <String>{
    splashScreenView,
    loginView,
    homeView,
    pastQuestionUploadScreen,
    pQViewScreen,
    timeTableView,
    addCourseView,
    notesUploadScreen,
    notesView,
    execsView,
    votingLoginScreen,
    votingScreen,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.splashScreenView,
      page: _i2.SplashScreenView,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i3.LoginView,
    ),
    _i1.RouteDef(
      Routes.homeView,
      page: _i4.HomeView,
    ),
    _i1.RouteDef(
      Routes.pastQuestionUploadScreen,
      page: _i5.PastQuestionUploadScreen,
    ),
    _i1.RouteDef(
      Routes.pQViewScreen,
      page: _i6.PQViewScreen,
    ),
    _i1.RouteDef(
      Routes.timeTableView,
      page: _i7.TimeTableView,
    ),
    _i1.RouteDef(
      Routes.addCourseView,
      page: _i8.AddCourseView,
    ),
    _i1.RouteDef(
      Routes.notesUploadScreen,
      page: _i9.NotesUploadScreen,
    ),
    _i1.RouteDef(
      Routes.notesView,
      page: _i10.NotesView,
    ),
    _i1.RouteDef(
      Routes.execsView,
      page: _i11.ExecsView,
    ),
    _i1.RouteDef(
      Routes.votingLoginScreen,
      page: _i12.VotingLoginScreen,
    ),
    _i1.RouteDef(
      Routes.votingScreen,
      page: _i13.VotingScreen,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplashScreenView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i2.SplashScreenView(),
        settings: data,
      );
    },
    _i3.LoginView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i3.LoginView(),
        settings: data,
      );
    },
    _i4.HomeView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i4.HomeView(),
        settings: data,
      );
    },
    _i5.PastQuestionUploadScreen: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i5.PastQuestionUploadScreen(),
        settings: data,
      );
    },
    _i6.PQViewScreen: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i6.PQViewScreen(),
        settings: data,
      );
    },
    _i7.TimeTableView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i7.TimeTableView(),
        settings: data,
      );
    },
    _i8.AddCourseView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i8.AddCourseView(),
        settings: data,
      );
    },
    _i9.NotesUploadScreen: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i9.NotesUploadScreen(),
        settings: data,
      );
    },
    _i10.NotesView: (data) {
      final args = data.getArgs<NotesViewArguments>(nullOk: false);
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => _i10.NotesView(
            courseCode: args.courseCode,
            title: args.title,
            level: args.level,
            key: args.key),
        settings: data,
      );
    },
    _i11.ExecsView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i11.ExecsView(),
        settings: data,
      );
    },
    _i12.VotingLoginScreen: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i12.VotingLoginScreen(),
        settings: data,
      );
    },
    _i13.VotingScreen: (data) {
      final args = data.getArgs<VotingScreenArguments>(nullOk: false);
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => _i13.VotingScreen(user: args.user, key: args.key),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class NotesViewArguments {
  const NotesViewArguments({
    required this.courseCode,
    required this.title,
    required this.level,
    this.key,
  });

  final String courseCode;

  final String title;

  final String level;

  final _i14.Key? key;

  @override
  String toString() {
    return '{"courseCode": "$courseCode", "title": "$title", "level": "$level", "key": "$key"}';
  }

  @override
  bool operator ==(covariant NotesViewArguments other) {
    if (identical(this, other)) return true;
    return other.courseCode == courseCode &&
        other.title == title &&
        other.level == level &&
        other.key == key;
  }

  @override
  int get hashCode {
    return courseCode.hashCode ^ title.hashCode ^ level.hashCode ^ key.hashCode;
  }
}

class VotingScreenArguments {
  const VotingScreenArguments({
    required this.user,
    this.key,
  });

  final _i15.User user;

  final _i14.Key? key;

  @override
  String toString() {
    return '{"user": "$user", "key": "$key"}';
  }

  @override
  bool operator ==(covariant VotingScreenArguments other) {
    if (identical(this, other)) return true;
    return other.user == user && other.key == key;
  }

  @override
  int get hashCode {
    return user.hashCode ^ key.hashCode;
  }
}

extension NavigatorStateExtension on _i16.NavigationService {
  Future<dynamic> navigateToSplashScreenView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.splashScreenView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPastQuestionUploadScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.pastQuestionUploadScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPQViewScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.pQViewScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTimeTableView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.timeTableView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddCourseView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.addCourseView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNotesUploadScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.notesUploadScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNotesView({
    required String courseCode,
    required String title,
    required String level,
    _i14.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.notesView,
        arguments: NotesViewArguments(
            courseCode: courseCode, title: title, level: level, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToExecsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.execsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToVotingLoginScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.votingLoginScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToVotingScreen({
    required _i15.User user,
    _i14.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.votingScreen,
        arguments: VotingScreenArguments(user: user, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSplashScreenView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.splashScreenView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPastQuestionUploadScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.pastQuestionUploadScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPQViewScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.pQViewScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTimeTableView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.timeTableView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddCourseView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.addCourseView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithNotesUploadScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.notesUploadScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithNotesView({
    required String courseCode,
    required String title,
    required String level,
    _i14.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.notesView,
        arguments: NotesViewArguments(
            courseCode: courseCode, title: title, level: level, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithExecsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.execsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithVotingLoginScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.votingLoginScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithVotingScreen({
    required _i15.User user,
    _i14.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.votingScreen,
        arguments: VotingScreenArguments(user: user, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
