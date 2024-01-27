import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utilities/l_text.dart';

class CourseBox extends StatelessWidget {
  String courseCode;
  String? courseTitle;
  String time;
  String? lect;
  Color color;
  void Function()? onTap;
  CourseBox(
      {required this.courseCode,
      this.courseTitle,
      required this.time,
      this.lect,
      required this.color,
      this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
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
      Positioned(
          right: 0,
          bottom: 0,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              child: Icon(
                CupertinoIcons.delete,
                color: Colors.white,
                size: 15,
              ),
            ),
          ))
    ]);
  }
}
