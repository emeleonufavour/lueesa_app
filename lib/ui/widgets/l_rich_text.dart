import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../utilities/l_text.dart';

class LRichText extends StatelessWidget {
  final String firstText;
  final String actionText;
  final Color color1;
  final Color color2;
  final double? fontsize1;
  final double? fontsize2;
  final void Function() action;
  const LRichText(
      {required this.firstText,
      required this.actionText,
      required this.action,
      this.color1 = const Color(0xFF667084),
      this.color2 = const Color(0xFF233E8B),
      this.fontsize1,
      this.fontsize2,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextWidget(
            text: firstText,
            color: color1,
            fontWeight: FontWeight.w500,
            fontsize: fontsize1 ?? 16.sp),
        const Gap(5),
        GestureDetector(
          onTap: () {
            action();
          },
          child: TextWidget(
              fontWeight: FontWeight.w500,
              text: actionText,
              color: color2,
              fontsize: fontsize2 ?? 16.sp),
        )
      ],
    );
  }
}
