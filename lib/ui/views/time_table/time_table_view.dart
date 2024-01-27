import 'dart:developer';

import 'package:collection/collection.dart';

import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:lueesa_app/core/models/time_table.dart';
import 'package:lueesa_app/core/services/storage_service.dart';
import 'package:lueesa_app/ui/style/app_assets.dart';
import 'package:lueesa_app/ui/style/app_dimensions.dart';
import 'package:lueesa_app/ui/utilities/l_text.dart';
import 'package:lueesa_app/ui/widgets/l_course_box.dart';
import 'package:lueesa_app/ui/widgets/l_dropdown.dart';
import 'package:lueesa_app/ui/widgets/l_get_button.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app_setup.locator.dart';
import 'time_table_vm.dart';

class TimeTableView extends StatelessWidget {
  const TimeTableView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => TimeTableViewModel(),
        builder: (context, model, _) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () => model.goToAddTimeTableScreen(),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                body: SafeArea(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LDropDown(
                                label: "Choose departmental level",
                                dropDownList: const [
                                  "500",
                                  "400",
                                  "300",
                                  "200",
                                  "100"
                                ],
                                hintText:
                                    'Choose the level timetable you want to see',
                                text: model.getLevel,
                                dropDownHeight:
                                    LDimensions.height(00.2, context),
                                onChanged: (val) {
                                  model.setLevel = val;
                                },
                                onTapped: (val) {}),
                            GetButton(
                                get: "Timetable",
                                onTap: () async =>
                                    await model.getTimetable(context)),
                            Gap(20.h),
                            if (model.isBusy)
                              Center(
                                child: Lottie.asset(
                                    "assets/lotties/hand-loading.json",
                                    animate: true,
                                    repeat: true),
                              ),
                            if ((model.timeTable.isEmpty && !model.isBusy) ||
                                (model.timeTable.isNotEmpty &&
                                    (model.allEmpty)))
                              Expanded(
                                  child: Center(
                                child: Column(
                                  children: [
                                    AppAssets.emptyBox(),
                                    Gap(25.h),
                                    const TextWidget(
                                        text: "Nothing to see here currently")
                                  ],
                                ),
                              )),
                            if (model.timeTable.isNotEmpty && !(model.allEmpty))
                              Expanded(
                                child: ListView.builder(
                                    itemCount: model.filteredTimeTable().length,
                                    itemBuilder: (context, index) {
                                      final timetable =
                                          model.filteredTimeTable();
                                      return DayContent(
                                        day: timetable[index]["day"],
                                        courses: timetable[index]["courses"],
                                        level: model.getLevel!,
                                      );
                                    }),
                              )
                          ],
                        )))),
          );
        });
  }
}

class DayContent extends StatefulWidget {
  String day;
  List courses;
  String level;
  DayContent(
      {required this.day,
      required this.courses,
      required this.level,
      super.key});

  @override
  State<DayContent> createState() => _DayContentState();
}

class _DayContentState extends State<DayContent> {
  final _navService = locator<NavigationService>();
  StorageService _storageService = StorageService();
  List<Map<String, dynamic>> _animatedCourses = [];

  void addCourses() {
    for (final i in widget.courses) {
      _animatedCourses.add(i);
    }
  }

  @override
  void initState() {
    addCourses();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //log("Animated courses ==> ${_animatedCourses}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: widget.day,
          fontWeight: FontWeight.bold,
          fontsize: 20.sp,
        ),
        Wrap(
          children: _animatedCourses
              .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0)
                      .copyWith(right: 16),
                  child: GestureDetector(
                    // onTap: () {
                    //   log("Timetable box should tap");
                    //   _navService.navigateToNotesView(
                    //       courseCode: e["code"],
                    //       title: e["title"],
                    //       level: e["lect"]);
                    // },
                    child: CourseBox(
                      onTap: () async {
                        bool result =
                            await _storageService.deleteCourseFromTimetable(
                                level: widget.level,
                                day: widget.day,
                                code: e["code"],
                                title: e["title"],
                                lect: e["lect"],
                                time: e['time']);
                        if (context.mounted) {
                          if (result) {
                            IconSnackBar.show(
                                context: context,
                                label: "Deleted successfully",
                                snackBarType: SnackBarType.save);
                            for (int i = _animatedCourses.length - 1;
                                i >= 0;
                                i--) {
                              if (const MapEquality().equals(
                                  _animatedCourses[i],
                                  Course(
                                          code: e["code"],
                                          title: e["title"],
                                          lect: e["lect"],
                                          time: e['time'])
                                      .toJson())) {
                                setState(() {
                                  _animatedCourses.removeAt(i);
                                });
                              }
                            }
                            // courses.remove(course.toJson());
                          } else {
                            IconSnackBar.show(
                                context: context,
                                label: "Could not delete",
                                snackBarType: SnackBarType.fail);
                          }
                        }
                      },
                      courseCode: e["code"],
                      time: e['time'],
                      lect: e["lect"],
                      courseTitle: e["title"],
                      color: colors[random.nextInt(colors.length)],
                    )
                        .animate()
                        .slideY(
                            begin: 5,
                            duration: Duration(
                              milliseconds:
                                  800 * (_animatedCourses.indexOf(e) + 1),
                            ),
                            curve: Curves.easeOut)
                        .fadeIn(
                          begin: 0.1,
                          delay: Duration(
                              milliseconds:
                                  300 * (_animatedCourses.indexOf(e) + 1)),
                        ),
                  )))
              .toList(),
        )
      ],
    );
  }
}
