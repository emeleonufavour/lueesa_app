import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:lueesa_app/ui/style/app_colors.dart';
import 'package:lueesa_app/ui/style/app_dimensions.dart';
import 'package:lueesa_app/ui/widgets/l_button.dart';
import 'package:lueesa_app/ui/widgets/l_dropdown.dart';
import 'package:lueesa_app/ui/widgets/l_textfield.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../utilities/l_text.dart';
import 'add_course_vm.dart';

class AddCourseBottomSheet extends StatelessWidget {
  const AddCourseBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => AddCourseViewModel(),
        onViewModelReady: (viewModel) {
          viewModel.codeCtr.addListener(() {
            viewModel.onTextChanged();
          });
          viewModel.lectCtr.addListener(() {
            viewModel.onTextChanged();
          });
          viewModel.timeCtr.addListener(() {
            viewModel.onTextChanged();
          });
          viewModel.titleCtr.addListener(() {
            viewModel.onTextChanged();
          });
        },
        onDispose: (viewModel) {
          viewModel.codeCtr.dispose();
          viewModel.lectCtr.dispose();
          viewModel.timeCtr.dispose();
          viewModel.titleCtr.dispose();
          viewModel.typingTime?.cancel();
        },
        builder: (context, model, _) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: LDimensions.height(0.9, context),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35)),
                color: Color(0xffF9FAFB),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 27.0, horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Input details
                    Column(
                      children: [
                        LDropDown(
                            label: "Course of study",
                            dropDownList: const [
                              "100",
                              "200",
                              "300",
                              "400",
                              "500"
                            ],
                            hintText: "Enter your course",
                            dropDownHeight: LDimensions.height(0.2, context),
                            text: model.level,
                            tapped: model.tapped,
                            onChanged: (val) {
                              model.level = val;
                            },
                            onTapped: (val) {
                              model.tapped = val!;
                            }),
                        LDropDown(
                            label: "Choose the day",
                            dropDownList: const [
                              "Monday",
                              "Tuesday",
                              "Wednesday",
                              "Thursday",
                              "Friday"
                            ],
                            hintText: "Choose day",
                            dropDownHeight: LDimensions.height(0.2, context),
                            text: model.day,
                            tapped: model.tapped,
                            onChanged: (val) {
                              model.day = val;
                            },
                            onTapped: (val) {
                              model.tapped = val!;
                            }),
                        LTextField(
                            onTap: () {
                              model.isTyping = true;
                            },
                            hintText: "Enter course code",
                            onChanged: (p0) {
                              model.isTyping = true;
                              log("Typing=> ${model.isTyping}");
                            },
                            textCtr: model.codeCtr),
                        LTextField(
                          hintText: "Enter course title",
                          textCtr: model.titleCtr,
                          onChanged: (p0) {
                            model.isTyping = true;
                            log("Typing=> ${model.isTyping}");
                          },
                          onTap: () {
                            model.isTyping = true;
                            model.typingTime?.cancel();
                          },
                        ),
                        LTextField(
                          hintText: "Enter duration of the course",
                          textCtr: model.timeCtr,
                          onChanged: (p0) {
                            model.isTyping = true;
                            log("Typing=> ${model.isTyping}");
                          },
                          onTap: () {
                            model.isTyping = true;
                          },
                        ),
                        LTextField(
                          hintText: "Enter lecturer name",
                          textCtr: model.lectCtr,
                          onChanged: (p0) {
                            model.isTyping = true;
                            log("Typing=> ${model.isTyping}");
                          },
                          onTap: () {
                            model.isTyping = true;
                          },
                        ),
                      ],
                    ),
                    if (!model.isTyping)
                      LButton(
                        label: "Enter course information",
                        color: AppColor.blue,
                        fct: () {},
                      )
                          .animate()
                          .fadeIn(duration: const Duration(milliseconds: 300))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
