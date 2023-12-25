import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lueesa_app/ui/style/app_colors.dart';

import '../utilities/l_text.dart';

class LAuthTextField extends StatelessWidget {
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
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? prefixText;
  final bool incorrectInput;
  const LAuthTextField(
      {this.label,
      required this.hintText,
      required this.textCtr,
      this.keyboardType,
      this.textFieldPadding,
      this.onFieldSubmitted,
      this.onEditingComplete,
      this.fillColor,
      this.validate,
      this.onChanged,
      this.prefixIcon,
      this.labelColor,
      this.suffixIcon,
      this.prefixText,
      this.incorrectInput = true,
      this.obscureText = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Padding(
        padding: textFieldPadding ?? const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (label != null)
            TextWidget(
              text: label!,
              fontWeight: FontWeight.w500,
              fontsize: 14,
              color: (labelColor ?? const Color(0xff101828)),
            ),
          const SizedBox(
            height: 7,
          ),
          SizedBox(
            height: size.height / 12,
            child: TextFormField(
              controller: textCtr,
              cursorColor: const Color(0xFF151624),
              obscureText: obscureText,
              keyboardType: keyboardType,
              onFieldSubmitted: onFieldSubmitted,
              validator: validate,
              onChanged: onChanged,
              onEditingComplete: onEditingComplete,
              style: const TextStyle(
                  fontFamily: 'EuclidCircularA',
                  color: Colors.black,
                  fontSize: 14),
              decoration: InputDecoration(
                prefixText: prefixText,
                hintText: hintText,
                hintStyle: const TextStyle(
                    fontFamily: 'EuclidCircularA',
                    color: Color(0xFF697D95),
                    fontSize: 14),
                filled: true,
                fillColor: textCtr.text.isEmpty
                    ? const Color.fromRGBO(248, 247, 251, 1)
                    : Colors.transparent,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(
                      color: textCtr.text.isEmpty
                          ? Colors.transparent
                          : AppColor.darkBlue,
                    )),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: const BorderSide(
                      color: AppColor.darkBlue,
                    )),
                prefixIcon: Icon(
                  Icons.lock_outline_rounded,
                  color: textCtr.text.isEmpty
                      ? const Color(0xFF151624).withOpacity(0.5)
                      : AppColor.darkBlue,
                  size: 16,
                ),
                suffix: Container(
                  alignment: Alignment.center,
                  width: 24.0,
                  height: 24.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: incorrectInput ? Colors.red : Colors.blueAccent,
                  ),
                  child: textCtr.text.isEmpty
                      ? const Center()
                      : Icon(
                          incorrectInput ? CupertinoIcons.xmark : Icons.check,
                          color: Colors.white,
                          size: 13,
                        ),
                ),
              ),
            ),
          ),
        ]));
  }

  LAuthTextField copyWith(
          {String? label,
          String? hintText,
          TextEditingController? textCtr,
          Color? labelColor,
          EdgeInsetsGeometry? textFieldPadding,
          Color? fillColor}) =>
      LAuthTextField(
        label: label ?? this.label,
        hintText: hintText ?? this.hintText,
        textCtr: textCtr ?? this.textCtr,
        labelColor: labelColor ?? this.labelColor,
        textFieldPadding: textFieldPadding ?? this.textFieldPadding,
        fillColor: fillColor ?? this.fillColor,
      );
}
