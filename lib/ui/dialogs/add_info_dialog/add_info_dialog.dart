import 'package:flutter/material.dart';
import 'package:lueesa_app/core/models/info_box.dart';
import 'package:lueesa_app/ui/utilities/l_text.dart';
import 'package:lueesa_app/ui/widgets/l_textfield.dart';
import 'package:stacked/stacked.dart';

import 'add_info_dialog_vm.dart';

class AddInfoDialog extends StatelessWidget {
  InfoBox? info;
  late AddInfoViewModel viewModel;
  AddInfoDialog({this.info, super.key})
      : viewModel = AddInfoViewModel(box: info);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => viewModel,
        onDispose: (viewModel) {
          viewModel.fromCtr.dispose();
          viewModel.toCtr.dispose();
          viewModel.msgCtr.dispose();
        },
        builder: (context, viewModel, _) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: TextWidget(
                text: viewModel.cameWithContent ? "Update note" : "Add a Note"),
            content: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LTextField(
                        label: "From",
                        hintText: "Who are you?",
                        textCtr: viewModel.fromCtr),
                    LTextField(
                        label: "To",
                        hintText: "Who are you sending to?",
                        textCtr: viewModel.toCtr),
                    LTextField(
                        label: "Message",
                        hintText: "What do you want them to see?",
                        textCtr: viewModel.msgCtr,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  // Close the dialog
                  Navigator.of(context).pop();
                },
                child: const TextWidget(
                  text: "Cancel",
                  color: Colors.red,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (viewModel.cameWithContent
                      ? await viewModel.updateNote(context)
                      : await viewModel.addNoteToStorage(context)) {
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                },
                child: TextWidget(
                  text: viewModel.cameWithContent ? "Update" : "Add",
                  color: Colors.white,
                ),
              ),
            ],
          );
        });
  }
}
