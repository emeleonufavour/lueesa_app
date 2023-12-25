import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lueesa_app/ui/views/pq_upload/pq_upload_vm.dart';
import 'package:lueesa_app/ui/widgets/l_auth_textfield.dart';
import 'package:lueesa_app/ui/widgets/l_button.dart';
import 'package:lueesa_app/ui/widgets/l_dropdown.dart';
import 'package:stacked/stacked.dart';

import '../../style/app_colors.dart';
import '../../widgets/l_textfield.dart';

class PastQuestionUploadScreen extends StatelessWidget {
  const PastQuestionUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => PQViewModel(),
        builder: (context, model, _) => Scaffold(
              backgroundColor: AppColor.darkBlue,
              //resizeToAvoidBottomInset: false,
              body: SafeArea(
                child: SizedBox(
                  height: size.height,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      //bg design, we use 3 svg img
                      Positioned(
                        left: -26,
                        top: 51.0,
                        child: SvgPicture.string(
                          '<svg viewBox="-26.0 51.0 91.92 91.92" ><path transform="matrix(0.707107, -0.707107, 0.707107, 0.707107, -26.0, 96.96)" d="M 48.75 0 L 65 32.5 L 48.75 65 L 16.24999809265137 65 L 0 32.5 L 16.25000381469727 0 Z" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.707107, -0.707107, 0.707107, 0.707107, -10.83, 105.24)" d="M 0 0 L 27.625 11.05000019073486 L 55.25 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.707107, -0.707107, 0.707107, 0.707107, 16.51, 93.51)" d="M 0 37.04999923706055 L 0 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                          width: 91.92,
                          height: 91.92,
                        ),
                      ),
                      Positioned(
                        right: 43.0,
                        top: -103,
                        child: SvgPicture.string(
                          '<svg viewBox="63.0 -103.0 268.27 268.27" ><path transform="matrix(0.5, -0.866025, 0.866025, 0.5, 63.0, 67.08)" d="M 147.2896423339844 0 L 196.3861999511719 98.19309997558594 L 147.2896423339844 196.3861999511719 L 49.09654235839844 196.3861999511719 L 0 98.19309234619141 L 49.09656143188477 0 Z" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.5, -0.866025, 0.866025, 0.5, 113.73, 79.36)" d="M 0 0 L 83.46413421630859 33.38565444946289 L 166.9282684326172 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.5, -0.866025, 0.866025, 0.5, 184.38, 23.77)" d="M 0 111.9401321411133 L 0 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                          width: 268.27,
                          height: 268.27,
                        ),
                      ),
                      Positioned(
                        right: -19,
                        top: 31.0,
                        child: SvgPicture.string(
                          '<svg viewBox="329.0 31.0 65.0 65.0" ><path transform="translate(329.0, 31.0)" d="M 48.75 0 L 65 32.5 L 48.75 65 L 16.24999809265137 65 L 0 32.5 L 16.25000381469727 0 Z" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(333.88, 47.58)" d="M 0 0 L 27.625 11.05000019073486 L 55.25 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(361.5, 58.63)" d="M 0 37.04999923706055 L 0 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                          width: 65.0,
                          height: 65.0,
                        ),
                      ),

                      //Main card
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 300),
                        bottom: model.tapped ? 30.0 : 100,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          //   alignment: Alignment.topCenter,
                          padding: const EdgeInsets.symmetric(vertical: 20)
                              .copyWith(bottom: 15),
                          width: size.width * 0.95,
                          height: model.tapped
                              ? size.height * 0.9
                              : size.height * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                //Enter image name
                                LTextField(
                                    label: "Image name",
                                    hintText: "Enter image name",
                                    textCtr: model.imgNameCtr),
                                GestureDetector(
                                  onTap: () {
                                    model.tapped = !model.tapped;
                                    log("Tapped => ${model.tapped}");
                                  },
                                  child: LDropDown(
                                    label: "Course Level",
                                    dropDownList: const [
                                      "500",
                                      "400",
                                      "300",
                                      "200",
                                      "100"
                                    ],
                                    hintText: "Choose course level",
                                    dropDownHeight: size.height * 0.2,
                                    text: model.level,
                                    onChanged: (value) {
                                      model.level = value;
                                    },
                                    tapped: model.tapped,
                                    onTapped: (bool? value) {
                                      model.tapped = value!;
                                    },
                                  ),
                                ),
                                LTextField(
                                    label: "Course code",
                                    hintText: "Enter course code",
                                    textCtr: model.courseCodeCtr),
                                LTextField(
                                    label: "Session",
                                    hintText: "2023/24",
                                    textCtr: model.sessionCtr),
                                LButton(
                                  label: model.imgFile == null
                                      ? "Pick image"
                                      : model.imgFile!.path.split('/').last,
                                  color: AppColor.darkBlue,
                                  fct: () {
                                    model.pickImage();
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: LButton(
                                    label: "Upload image",
                                    buttonWidget: model.isBusy
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : null,
                                    color: Colors.red,
                                    fct: () => model.uploadImage(context),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
