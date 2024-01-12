import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utilities/l_text.dart';

class CourseBox extends StatelessWidget {
  String courseCode;
  String? courseTitle;
  String time;
  String? lect;
  Color color;
  CourseBox(
      {required this.courseCode,
      this.courseTitle,
      required this.time,
      this.lect,
      required this.color,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
      },
      child: Container(
        width: 150,
        color: color,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Course code
            TextWidget(
              text: courseCode,
              fontsize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
            //Course title
            if (courseTitle != null)
              TextWidget(
                text: courseTitle!,
                fontsize: 16.sp,
              ),
            //Time
            TextWidget(text: time),
            //Lecturer
            if (lect != null) TextWidget(text: lect!)
          ],
        ),
      ),
    );
  }
}
