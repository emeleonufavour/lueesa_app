import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lueesa_app/core/services/storage_service.dart';
import 'package:lueesa_app/ui/style/app_colors.dart';
import 'package:lueesa_app/ui/utilities/l_text.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app_setup.locator.dart';

List<Color> colors = AppColor().courseColors;
math.Random random = math.Random();

class TimeTableViewModel extends BaseViewModel {
  final _storageService = locator<StorageService>();
  String? _level;
  List<Map<String, dynamic>> timeTable = [];

  String? get getLevel => _level;

  set setLevel(String? value) {
    _level = value;
    notifyListeners();
  }

  getTimetable(BuildContext context) async {
    if (_level != null) {
      setBusy(true);
      try {
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
    // log("Timetable response from Firebase ==> $timeTable");
    // log("Day ==> ${timeTable[0]["day"]}");
    // log("Courses ==> ${timeTable[0]["courses"]}, ");
    // log("Course ==> ${timeTable[0]["courses"][0]}");
    // log("Course code ==> ${timeTable[0]["courses"][0]["code"]}");
    // log("Course lecturer ==> ${timeTable[0]["courses"][0]["lect"]}");
    // log("Course title ==> ${timeTable[0]["courses"][0]["title"]}");
    // log("Course time ==> ${timeTable[0]["courses"][0]["time"]}");
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