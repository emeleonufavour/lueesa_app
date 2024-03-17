import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../style/app_colors.dart';
import '../utilities/l_text.dart';

class SmallButton extends StatefulWidget {
  String text;
  void Function()? onTap;
  SmallButton({required this.text, required this.onTap, super.key});

  @override
  State<SmallButton> createState() => _GetButtonState();
}

class _GetButtonState extends State<SmallButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 150),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        //onTap: widget.onTap,
        onTap: () {
          _controller.forward();
          Future.delayed(const Duration(milliseconds: 200), () {
            _controller.reverse();
            widget.onTap!();
          });
        },
        child: ScaleTransition(
          scale: Tween<double>(
            begin: 1.0,
            end: 0.9,
          ).animate(_controller),
          child: Container(
            decoration: const BoxDecoration(
                color: AppColor.blue,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Padding(
                padding: const EdgeInsets.all(15),
                child: TextWidget(
                  text: widget.text,
                  color: Colors.white,
                )),
          ),
        ),
      ),
    );
  }
}
