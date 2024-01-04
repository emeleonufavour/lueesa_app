import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lueesa_app/app/routing/screen_path.dart';
import 'package:lueesa_app/ui/style/app_assets.dart';
import 'package:lueesa_app/ui/style/app_colors.dart';
import 'package:gap/gap.dart';
import 'package:lueesa_app/ui/style/app_dimensions.dart';
import 'package:lueesa_app/ui/utilities/l_text.dart';
import 'package:lueesa_app/ui/widgets/l_auth_textfield.dart';
import 'package:stacked/stacked.dart';

import '../../../utilities/l_validator.dart';
import 'login_vm.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => LoginViewModel(),
        onViewModelReady: (viewModel) {
          Future.delayed(const Duration(seconds: 1), () {
            viewModel.open = true;
          });
          // viewModel.passController.addListener(() {
          //   viewModel.onTextChanged();
          // });
        },
        onDispose: (viewModel) {
          viewModel.passController.dispose();
          viewModel.emailController.dispose();
          viewModel.typingTime?.cancel();
        },
        builder: (context, model, _) => Scaffold(
              backgroundColor: AppColor.darkBlue,
              resizeToAvoidBottomInset: model.resize,
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
                      Positioned(
                        bottom: 75.0,
                        child: Form(
                          key: model.formKey,
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                width: size.width * 0.9,
                                height: size.height * 0.7,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Gap(50),
                                    //email & password textField
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: LAuthTextField(
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            incorrectInput:
                                                model.incorrectEmail,
                                            hintText: "Enter your email",
                                            validate: (value) {
                                              return LValidator.validateEmail(
                                                  value!);
                                            },
                                            onChanged: (value) {
                                              final error =
                                                  LValidator.validateEmail(
                                                      value);
                                              model.incorrectEmail =
                                                  !(error == null);
                                              log("Incorrect input: ${model.incorrectEmail}");
                                            },
                                            textCtr: model.emailController)),
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                    //password
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: LAuthTextField(
                                        onTap: () {
                                          model.resize = true;
                                          model.typingTime?.cancel();
                                        },
                                        incorrectInput: model.incorrectPassword,
                                        hintText: "Enter your password",
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        validate: (value) {
                                          return LValidator.validatePassword(
                                              value!);
                                        },
                                        textCtr: model.passController,
                                        focusNode: model.passwordFocusNode,
                                        obscureText: true,
                                        onEditingComplete: () {
                                          model.passwordFocusNode.unfocus();
                                          model.onTextChanged();
                                        },
                                        onChanged: (value) {
                                          // model.resize = true;
                                          // log("Resize => ${model.resize}");
                                          final error =
                                              LValidator.validatePassword(
                                                  value);
                                          model.incorrectPassword =
                                              !(error == null);
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.03,
                                    ),

                                    //remember & forget text
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(
                                    //       horizontal: 20.0),
                                    //   child: Row(
                                    //     children: [
                                    //       Container(
                                    //         alignment: Alignment.center,
                                    //         width: 20.0,
                                    //         height: 20.0,
                                    //         decoration: BoxDecoration(
                                    //           borderRadius:
                                    //               BorderRadius.circular(5.0),
                                    //           color: const Color(0xFF21899C),
                                    //         ),
                                    //         child: const Icon(
                                    //           Icons.check,
                                    //           size: 13,
                                    //           color: Colors.white,
                                    //         ),
                                    //       ),
                                    //       const SizedBox(
                                    //         width: 8,
                                    //       ),
                                    //       const Text(
                                    //         'Remember me',
                                    //       ),
                                    //       const Spacer(),
                                    //       const Text(
                                    //         'Forgot password',
                                    //         textAlign: TextAlign.right,
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    SizedBox(
                                      height: size.height * 0.04,
                                    ),

                                    //sign in button
                                    GestureDetector(
                                      onTap: () async {
                                        await model.login(context);
                                      },
                                      child: Container(
                                          alignment: Alignment.center,
                                          height: size.height / 13,
                                          width: size.width * 0.7,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            color: AppColor.darkBlue,
                                          ),
                                          child: model.isBusy
                                              ? const CircularProgressIndicator(
                                                  color: Colors.white,
                                                )
                                              : const TextWidget(
                                                  text: "Sign In",
                                                  textAlign: TextAlign.center,
                                                  color: Colors.white,
                                                )),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      AnimatedPositioned(
                        duration: const Duration(seconds: 1),
                        top: model.isOpen
                            ? (model.resize
                                ? -100
                                : LDimensions.height(0.18, context))
                            : -200,
                        left: size.width * 0.39,
                        child: AppAssets.lueesaLogo(100),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
