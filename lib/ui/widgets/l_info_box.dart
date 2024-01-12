import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../style/app_colors.dart';
import '../utilities/l_text.dart';

class LInfoBox extends StatelessWidget {
  const LInfoBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: AppColor.blue, borderRadius: BorderRadius.circular(20)),
        child: Column(children: [
          const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  text: "From: Favour",
                  color: Colors.white,
                ),
                TextWidget(
                  text: "To: Abots",
                  color: Colors.white,
                ),
              ]),
          Gap(7.h),
          const TextWidget(
            text:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
            color: Colors.white,
          ),
        ]),
      ),
    );
  }
}
