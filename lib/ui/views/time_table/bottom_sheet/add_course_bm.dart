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

class AddCourseView extends StatelessWidget {
  const AddCourseView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => AddCourseViewModel(),
        onViewModelReady: (viewModel) {},
        onDispose: (viewModel) {
          viewModel.codeCtr.dispose();
          viewModel.lectCtr.dispose();
          viewModel.timeCtr.dispose();
          viewModel.titleCtr.dispose();
          viewModel.typingTime?.cancel();
        },
        builder: (context, model, _) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 27.0, horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Input details
                      Column(
                        children: [
                          LDropDown(
                              label: "Level of study",
                              dropDownList: const [
                                "100",
                                "200",
                                "300",
                                "400",
                                "500"
                              ],
                              hintText: "Enter the level",
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
                              focusNode: model.codeFocusNode,
                              onTap: () {
                                model.isTyping = true;
                                model.typingTime?.cancel();
                              },
                              hintText: "Enter course code",
                              label: "Course code",
                              // onChanged: (p0) {
                              //   model.isTyping = true;
                              //   log("Typing=> ${model.isTyping}");
                              // },
                              onEditingComplete: () {
                                model.codeFocusNode.unfocus();
                                model.onTextChanged();
                              },
                              textCtr: model.codeCtr),
                          LTextField(
                            hintText: "Enter course title",
                            label: "Course title",
                            focusNode: model.titleFocusNode,
                            textCtr: model.titleCtr,
                            onTap: () {
                              model.isTyping = true;
                              model.typingTime?.cancel();
                            },
                            onEditingComplete: () {
                              model.titleFocusNode.unfocus();
                              model.onTextChanged();
                            },
                            // onChanged: (p0) {
                            //   model.isTyping = true;
                            //   log("Typing=> ${model.isTyping}");
                            // },
                          ),
                          LTextField(
                            label: "Course duration",
                            hintText: "Enter duration of the course",
                            textCtr: model.timeCtr,
                            // onChanged: (p0) {
                            //   model.isTyping = true;
                            //   log("Typing=> ${model.isTyping}");
                            // },
                            focusNode: model.timeFocusNode,

                            onTap: () {
                              model.isTyping = true;
                              model.typingTime?.cancel();
                            },
                            onEditingComplete: () {
                              model.timeFocusNode.unfocus();
                              model.onTextChanged();
                            },
                          ),
                          LTextField(
                            label: "Lecturer name",
                            hintText: "Enter lecturer name",
                            textCtr: model.lectCtr,
                            // onChanged: (p0) {
                            //   model.isTyping = true;
                            //   log("Typing=> ${model.isTyping}");
                            // },
                            focusNode: model.lectFocusNode,

                            onTap: () {
                              model.isTyping = true;
                              model.typingTime?.cancel();
                            },
                            onEditingComplete: () {
                              model.lectFocusNode.unfocus();
                              model.onTextChanged();
                            },
                          ),
                        ],
                      ),
                      Gap(40.h),
                      if (!model.isTyping)
                        LButton(
                          buttonWidget: model.isBusy
                              ? CircularProgressIndicator()
                              : TextWidget(text: "Enter course information"),
                          label: "Enter course information",
                          color: AppColor.blue,
                          fct: () => model.addCourseToDay(context),
                        )
                            .animate()
                            .fadeIn(duration: const Duration(milliseconds: 300))
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
