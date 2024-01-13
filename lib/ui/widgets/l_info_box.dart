import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lueesa_app/core/models/info_box.dart';
import 'package:lueesa_app/ui/dialogs/add_info_dialog/add_info_dialog.dart';

import '../../core/services/storage_service.dart';
import '../style/app_colors.dart';
import '../utilities/l_text.dart';

class LInfoBox extends StatefulWidget {
  String from;
  String to;
  String data;
  String time;
  bool showMenu;
  bool expand;
  LInfoBox(
      {required this.from,
      required this.to,
      required this.data,
      required this.time,
      required this.showMenu,
      required this.expand,
      super.key});

  @override
  State<LInfoBox> createState() => _LInfoBoxState();
}

class _LInfoBoxState extends State<LInfoBox>
    with SingleTickerProviderStateMixin {
  StorageService _service = StorageService();
  late AnimationController _controller;
  Offset? _menuPosition;
  // bool showMenu = false;
  // bool expand = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
        child: GestureDetector(
          onLongPress: () {
            RenderBox renderBox = context.findRenderObject() as RenderBox;
            Offset position = renderBox.localToGlobal(Offset.zero);
            HapticFeedback.lightImpact();
            _controller.forward();
            setState(() {
              _menuPosition = position;
              widget.expand = true;
            });
            Future.delayed(Duration(milliseconds: 200), () {
              setState(() {
                widget.showMenu = true;
              });
            });
          },
          child: ScaleTransition(
            scale: Tween<double>(
              begin: widget.expand ? 1.0 : 1.0,
              end: widget.expand ? 1.02 : 0.98,
            ).animate(_controller),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: AppColor.blue,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            text: "From: ${widget.from}",
                            color: Colors.white,
                          ),
                          TextWidget(
                            text: "To: ${widget.to}",
                            color: Colors.white,
                          ),
                        ]),
                    Gap(7.h),
                    TextWidget(
                      text: widget.data,
                      color: Colors.white,
                      textAlign: TextAlign.start,
                    ),
                  ]),
            ),
          ),
        ),
      ),
      if (_menuPosition != null && widget.showMenu)
        Positioned(
          right: 10,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.white.withOpacity(0.2), width: 2.5),
                    color: Colors.grey.withOpacity(0.1)),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AddInfoDialog(
                                info: InfoBox(
                                    from: widget.from,
                                    to: widget.to,
                                    message: widget.data,
                                    time: widget.time),
                              );
                            });
                      },
                      child: Row(children: [
                        const Icon(
                          Icons.edit,
                          size: 17,
                          color: Colors.blue,
                        ),
                        Gap(15.w),
                        const TextWidget(
                          text: "Edit",
                          color: Colors.blue,
                        )
                      ]),
                    ),
                    Gap(12.h),
                    GestureDetector(
                      onTap: () async {
                        log("Should delete box with id ==> ${widget.time}");
                        try {
                          await _service.deleteInfo(widget.time);
                        } catch (e) {
                          log(e.toString());
                        }
                      },
                      child: Row(children: [
                        const Icon(
                          CupertinoIcons.delete,
                          color: Colors.red,
                          size: 17,
                        ),
                        Gap(4.w),
                        const TextWidget(
                          text: "Delete",
                          color: Colors.red,
                        )
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ).animate().fadeIn()
    ]);
  }
}
