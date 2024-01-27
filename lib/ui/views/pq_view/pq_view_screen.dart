import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:lueesa_app/ui/style/app_colors.dart';
import 'package:lueesa_app/ui/utilities/l_text.dart';
import 'package:lueesa_app/ui/widgets/l_button.dart';
import 'package:lueesa_app/ui/widgets/l_dropdown.dart';
import 'package:lueesa_app/ui/widgets/l_get_button.dart';
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
        builder: (context, viewModel, _) => GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Scaffold(
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
                              maxLines: 1,
                              keyboardType: TextInputType.text,
                              hintText: "Type in course code eg. eie310",
                              textCtr: viewModel.courseCodeCtr),
                          LTextField(
                              label: "Session",
                              maxLines: 1,
                              keyboardType: TextInputType.text,
                              hintText: "Type in session eg. 2023_24",
                              textCtr: viewModel.sessionCtr),
                          GetButton(
                            get: "Papers",
                            onTap: () async =>
                                await viewModel.getPapers(context),
                          ),
                          if (viewModel.isBusy)
                            Center(
                              child: Lottie.asset(
                                  "assets/lotties/hand-loading.json",
                                  animate: true,
                                  repeat: true),
                            ),
                          if (viewModel.contents.isNotEmpty &&
                              !viewModel.isBusy)
                            Images(
                                viewModel: viewModel,
                                contents: viewModel.contents)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}

class Images extends StatefulWidget {
  PQViewViewModel viewModel;
  List<Map<String, String>> contents;
  Images({required this.viewModel, required this.contents, super.key});

  @override
  State<Images> createState() => _ImagesState();
}

class _ImagesState extends State<Images> {
  List<Map<String, String>> _animatedContents = [];

  void addImageBoxes() {
    for (final i in widget.contents) {
      _animatedContents.add(i);
    }
  }

  @override
  void initState() {
    addImageBoxes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _animatedContents.length,
      itemBuilder: (context, index) {
        String name = _animatedContents[index]["name"]!;
        String imageUrl = _animatedContents[index]["downloadUrl"]!;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: ImageBox(
            name: name,
            imageUrl: imageUrl,
            download: () async => await widget.viewModel.saveToGallery(
                downloadUrl: imageUrl, fileName: name, context: context),
            isDownloading: widget.viewModel.isDownloading,
            downloadProgress: widget.viewModel.progress,
          )
              .animate()
              .slideY(
                  begin: 5,
                  duration: Duration(
                    milliseconds: 800 * (index + 1),
                  ),
                  curve: Curves.easeOut)
              .fadeIn(
                begin: 0.1,
                delay: Duration(milliseconds: 300 * (index + 1)),
              ),
        );
      },
    );
  }
}
