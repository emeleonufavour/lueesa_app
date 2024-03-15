import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lueesa_app/ui/style/app_dimensions.dart';

import '../utilities/l_text.dart';

class LTextField extends StatelessWidget {
  final String? label;
  final TextEditingController textCtr;
  final String hintText;
  final String? Function(String?)? validate;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final Color? labelColor;
  final Color? fillColor;
  final EdgeInsetsGeometry? textFieldPadding;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? prefixText;
  final FocusNode? focusNode;
  final int? maxLines;
  final TextInputAction? textInputAction;
  const LTextField(
      {this.label,
      required this.hintText,
      required this.textCtr,
      this.keyboardType,
      this.textFieldPadding,
      this.onFieldSubmitted,
      this.onEditingComplete,
      this.onTap,
      this.fillColor,
      this.validate,
      this.onChanged,
      this.prefixIcon,
      this.labelColor,
      this.suffixIcon,
      this.prefixText,
      this.focusNode,
      this.maxLines,
      this.textInputAction,
      this.obscureText = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: textFieldPadding ?? EdgeInsets.symmetric(vertical: 12.0.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (label != null)
            TextWidget(
              text: label!,
              fontWeight: FontWeight.w500,
              fontsize: 14.sp,
              color: (labelColor ?? const Color(0xff101828)),
            ),
          SizedBox(
            height: 7.h,
          ),
          Container(
            height: LDimensions.height(0.08, context),
            width: double.maxFinite,
            decoration: const BoxDecoration(
                // color:,
                ),
            child: TextFormField(
              focusNode: focusNode,
              onTap: onTap,
              obscureText: obscureText,
              keyboardType: keyboardType,
              controller: textCtr,
              validator: validate,
              onChanged: onChanged,
              maxLines: maxLines,
              onFieldSubmitted: onFieldSubmitted,
              onEditingComplete: onEditingComplete,
              textInputAction: textInputAction,
              style: TextStyle(
                  fontFamily: 'EuclidCircularA',
                  color: Colors.black,
                  fontSize: 14.sp),
              decoration: InputDecoration(
                prefixText: prefixText,
                filled: true,
                fillColor: fillColor ?? (const Color(0xFFE8EDF1)),
                hintStyle: TextStyle(
                    fontFamily: 'EuclidCircularA',
                    color: const Color(0xFF697D95),
                    fontSize: 14.sp),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none)),
                hintText: hintText,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
              ),
            ),
          )
        ]));
  }

  LTextField copyWith(
          {String? label,
          String? hintText,
          TextEditingController? textCtr,
          Color? labelColor,
          EdgeInsetsGeometry? textFieldPadding,
          Color? fillColor}) =>
      LTextField(
        label: label ?? this.label,
        hintText: hintText ?? this.hintText,
        textCtr: textCtr ?? this.textCtr,
        labelColor: labelColor ?? this.labelColor,
        textFieldPadding: textFieldPadding ?? this.textFieldPadding,
        fillColor: fillColor ?? this.fillColor,
      );
}
