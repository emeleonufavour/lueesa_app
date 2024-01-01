import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../style/app_colors.dart';
import '../utilities/l_text.dart';

class GetButton extends StatelessWidget {
  String get;
  void Function()? onTap;
  GetButton({required this.get, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: const BoxDecoration(
              color: AppColor.blue,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Padding(
              padding: const EdgeInsets.all(15),
              child: TextWidget(
                text: "Get $get",
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}
