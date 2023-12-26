import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:lueesa_app/ui/style/app_colors.dart';
import 'package:lueesa_app/ui/utilities/l_text.dart';
import 'package:lueesa_app/ui/widgets/l_button.dart';
import 'package:lueesa_app/ui/widgets/l_dropdown.dart';
import 'package:lueesa_app/ui/widgets/l_textfield.dart';
import 'package:stacked/stacked.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../widgets/image_box.dart';
import 'pq_view_vm.dart';

class PQViewScreen extends StatelessWidget {
  const PQViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => PQViewViewModel(),
        builder: (context, viewModel, _) => Scaffold(
              // body: ImagesInDirectory(
              //     directoryPath: 'past_questions/300/eie310/'),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        LDropDown(
                          label: "Level of Study",
                          dropDownList: const [
                            "500",
                            "400",
                            "300",
                            "200",
                            "100"
                          ],
                          hintText: "Choose Level of Study",
                          dropDownHeight: size.height * 0.2,
                          text: viewModel.level,
                          onChanged: (val) {
                            viewModel.level = val!;
                          },
                          onTapped: (bool? value) {},
                        ),
                        LTextField(
                            label: "Course Code",
                            hintText: "Type in course code eg. eie310",
                            textCtr: viewModel.courseCodeCtr),
                        LTextField(
                            label: "Session",
                            hintText: "Type in session eg. 2023_24",
                            textCtr: viewModel.sessionCtr),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () async =>
                                await viewModel.getPapers(context),
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: AppColor.blue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: const Padding(
                                  padding: EdgeInsets.all(15),
                                  child: TextWidget(
                                    text: "Get papers",
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                        ),
                        if (viewModel.isBusy)
                          Center(
                            child: Lottie.asset(
                                "assets/lotties/hand-loading.json",
                                animate: true,
                                repeat: true),
                          ),
                        if (viewModel.contents.isNotEmpty)
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: viewModel.contents.length,
                            itemBuilder: (context, index) {
                              String name = viewModel.contents[index]["name"]!;
                              String imageUrl =
                                  viewModel.contents[index]["downloadUrl"]!;
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                child: ImageBox(
                                    name: name,
                                    imageUrl: imageUrl,
                                    download: () async =>
                                        await viewModel.saveToGallery()
                                    // await viewModel.download(
                                    //     downloadUrl: imageUrl,
                                    //     fileName: name),
                                    ),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
