import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utilities/l_text.dart';

class LButton extends StatelessWidget {
  const LButton(
      {super.key,
      required this.label,
      this.fct,
      required this.color,
      this.withWidth,
      this.borderColor,
      this.textColor,
      this.horizontalPadding,
      this.verticalPadding,
      this.icon,
      this.iconColor,
      this.isPrefixPresent = false,
      this.prefixWidget,
      this.buttonWidget});
  final String label;
  final VoidCallback? fct;
  final Color color;
  final bool? withWidth;
  final Color? borderColor;
  final Color? textColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final IconData? icon;
  final Color? iconColor;
  final bool isPrefixPresent;
  final Widget? prefixWidget;
  final Widget? buttonWidget;
  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context).primaryColor;
    return GestureDetector(
      onTap: fct,
      child: Container(
        alignment: Alignment.center,
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 10.w,
          vertical: verticalPadding ?? 14.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: color,
          // border: Border.all(
          //   width: 2,
          //   //color: borderColor ?? Colors.white,
          // ),
        ),
        child: buttonWidget ??
            TextWidget(
              textAlign: TextAlign.center,
              text: label,
              fontWeight: FontWeight.w700,
              fontsize: 15.sp,
              color: textColor ?? Colors.white,
            ),
      ),
    );
  }
}
