import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lueesa_app/ui/style/app_colors.dart';

import '../../../utilities/l_text.dart';

class VoteeBox extends StatefulWidget {
  void Function() onTap;
  String name;
  bool? isSelected;
  VoteeBox(
      {required this.name, required this.onTap, this.isSelected, super.key});

  @override
  State<VoteeBox> createState() => _VoteeBoxState();
}

class _VoteeBoxState extends State<VoteeBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: () {
          _animationController.forward();
          Future.delayed(const Duration(milliseconds: 200), () {
            _animationController.reverse();
            widget.onTap();
          });
        },
        child: ScaleTransition(
          scale:
              Tween<double>(begin: 1.0, end: 0.9).animate(_animationController),
          child: Container(
            width: size.width * 0.5,
            height: size.height * 0.06,
            decoration: BoxDecoration(
                color: (widget.isSelected ?? false)
                    ? Colors.green
                    : AppColor.darkBlue,
                borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: TextWidget(
                text: widget.name,
                color: Colors.white,
                fontsize: 18.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
