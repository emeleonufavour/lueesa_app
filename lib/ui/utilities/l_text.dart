import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    required this.text,
    this.fontWeight,
    this.fontsize,
    this.color = const Color(0xff101828),
    this.textAlign,
    this.lineThrough,
    this.overflow,
  });
  final String text;
  final double? fontsize;
  final FontWeight? fontWeight;
  final Color color;
  final TextAlign? textAlign;
  final TextDecoration? lineThrough;
  final TextOverflow? overflow;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        overflow: overflow,
        fontFamily: 'EuclidCircularA',
        fontSize: fontsize ?? 16.sp,
        fontWeight: fontWeight ?? FontWeight.w500,
        color: color,
        decoration: lineThrough,
      ),
      textAlign: textAlign,
    );
  }
}
