import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:lueesa_app/ui/style/app_dimensions.dart';
import 'package:lueesa_app/ui/utilities/l_text.dart';
import 'package:lueesa_app/ui/widgets/l_course_box.dart';
import 'package:lueesa_app/ui/widgets/l_dropdown.dart';
import 'package:lueesa_app/ui/widgets/l_get_button.dart';
import 'package:stacked/stacked.dart';

import '../../style/app_colors.dart';
import 'time_table_vm.dart';

class TimeTableView extends StatelessWidget {
  const TimeTableView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => TimeTableViewModel(),
        builder: (context, model, _) {
          return Scaffold(
              floatingActionButton: FloatingActionButton(onPressed: () {}),
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
                              dropDownHeight: LDimensions.height(00.2, context),
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
                          if (model.timeTable.isNotEmpty)
                            Expanded(
                              child: ListView.builder(
                                  itemCount: model.timeTable.length,
                                  itemBuilder: (context, index) {
                                    final timetable = model.timeTable;
                                    return DayContent(
                                        day: timetable[index]["day"],
                                        courses: timetable[index]["courses"]);
                                  }),
                            )
                        ],
                      ))));
        });
  }
}

class DayContent extends StatefulWidget {
  String day;
  List courses;
  DayContent({required this.day, required this.courses, super.key});

  @override
  State<DayContent> createState() => _DayContentState();
}

class _DayContentState extends State<DayContent> {
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
                  child: CourseBox(
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
                      )))
              .toList(),
        )
      ],
    );
  }
}
