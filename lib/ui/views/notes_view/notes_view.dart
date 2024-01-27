import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lueesa_app/ui/utilities/l_text.dart';
import 'package:lueesa_app/ui/views/notes_view/notes_view_vm.dart';
import 'package:stacked/stacked.dart';

import '../note_upload/note_upload_vm.dart';

class NotesView extends StatelessWidget {
  String courseCode;
  String title;
  String level;
  late NotesViewModel viewModel;
  NotesView(
      {required this.courseCode,
      required this.title,
      required this.level,
      super.key})
      : viewModel = NotesViewModel(level: level, courseCode: courseCode);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => viewModel,
        onViewModelReady: (viewModel) {
          viewModel.getNotes();
        },
        builder: (context, model, _) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      const TextWidget(text: "Course code:  "),
                      TextWidget(
                        text: courseCode,
                        fontsize: 25.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ]),
                    Gap(20.h),
                    Row(
                      children: [
                        const TextWidget(text: "Course title:  "),
                        TextWidget(
                          text: title,
                          fontsize: 18.sp,
                        ),
                      ],
                    ),
                    Gap(20.h),
                    TextWidget(
                      text: "Notes",
                      fontsize: 25.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: viewModel.notes?.length,
                          itemBuilder: ((context, index) {
                            return NoteBox();
                          })),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class NoteBox extends StatelessWidget {
  const NoteBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5), // Set the shadow color
          spreadRadius: 5, // Set the spread radius of the shadow
          blurRadius: 7, // Set the blur radius of the shadow
          offset: Offset(0, 3), // Set the offset of the shadow
        ),
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Note
          TextWidget(text: "View"), TextWidget(text: "Delete")
        ],
      ),
    );
  }
}
