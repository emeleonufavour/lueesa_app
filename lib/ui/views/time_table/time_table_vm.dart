import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lueesa_app/app/app_setup.router.dart';
import 'package:lueesa_app/core/services/storage_service.dart';
import 'package:lueesa_app/ui/style/app_colors.dart';
import 'package:lueesa_app/ui/utilities/l_text.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app_setup.locator.dart';

List<Color> colors = AppColor().courseColors;
math.Random random = math.Random();

class TimeTableViewModel extends BaseViewModel {
  final _storageService = locator<StorageService>();
  final _navService = locator<NavigationService>();

  String? _level;
  List<Map<String, dynamic>> timeTable = [];

  bool get allEmpty =>
      timeTable.every((element) => (element["courses"] as List).isEmpty);

  String? get getLevel => _level;

  set setLevel(String? value) {
    _level = value;
    notifyListeners();
  }

  List<Map<String, dynamic>> filteredTimeTable() {
    List<Map<String, dynamic>> result = timeTable
        .where((element) => (element["courses"] as List).isNotEmpty)
        .toList();
    return result;
  }

  goToAddTimeTableScreen() => _navService.navigateToAddCourseView();

  getTimetable(BuildContext context) async {
    if (_level != null) {
      setBusy(true);
      try {
        timeTable = [];
        timeTable = await _storageService.getTimetable(_level!)
            as List<Map<String, dynamic>>;
        notifyListeners();
        if (context.mounted) {
          IconSnackBar.show(
              context: context,
              label: "Successful",
              snackBarType: SnackBarType.save);
        }
      } catch (e) {
        log("Error getting time table ==> $e");
        if (context.mounted) {
          IconSnackBar.show(
              context: context,
              label: "Error getting Time table",
              snackBarType: SnackBarType.fail);
        }
      }
    } else {
      IconSnackBar.show(
          context: context,
          label: "What level???",
          snackBarType: SnackBarType.fail);
    }
    setBusy(false);
  }

  deleteCourseFromTimetable(
      {required BuildContext context,
      required String day,
      required String code,
      required String title,
      required String lect,
      required String time}) async {
    bool result = await _storageService.deleteCourseFromTimetable(
        level: _level!,
        day: day,
        code: code,
        title: title,
        lect: lect,
        time: time);
    if (context.mounted) {
      if (result) {
        IconSnackBar.show(
            context: context,
            label: "Deleted successfully",
            snackBarType: SnackBarType.save);
        // for (int i = _animatedCourses.length - 1; i >= 0; i--) {
        //   if (const MapEquality().equals(
        //       _animatedCourses[i],
        //       Course(
        //               code: e["code"],
        //               title: e["title"],
        //               lect: e["lect"],
        //               time: e['time'])
        //           .toJson())) {
        //     _animatedCourses.removeAt(i);
        //   }
        // }
        // courses.remove(course.toJson());
      } else {
        IconSnackBar.show(
            context: context,
            label: "Could not delete",
            snackBarType: SnackBarType.fail);
      }
    }
  }

  // List<Map<String, dynamic>> timeTable = [
  //   {
  //     "day": "Monday",
  //     "courses": [
  //       {
  //         "code": "EIE 310",
  //         "title": "Engineering Maths",
  //         "time": "8:00-10:00am",
  //         "lect": "Engr. Alimi",
  //       },
  //       {
  //         "code": "EIE 311",
  //         "title": "Magnetic fields",
  //         "time": "10:00-12:00am",
  //         "lect": "Engr. Bode",
  //       },
  //     ],
  //   },
  //   {
  //     "day": "Tuesday",
  //     "courses": [
  //       {
  //         "code": "EIE 313",
  //         "title": "Electronics",
  //         "time": "12:00-2:00am",
  //         "lect": "Engr. Dickson",
  //       },
  //       {
  //         "code": "EIE 318",
  //         "title": "Communication",
  //         "time": "10:00-12:00am",
  //         "lect": "Engr. Igbinosa",
  //       },
  //       {
  //         "code": "EIE 311",
  //         "title": "Magnetic fields",
  //         "time": "10:00-12:00am",
  //         "lect": "Engr. Bode",
  //       },
  //     ],
  //   }
  // ];
}
//  "color": colors[random.nextInt(colors.length)]