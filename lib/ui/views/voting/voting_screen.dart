import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lueesa_app/ui/utilities/l_text.dart';
import 'package:lueesa_app/ui/views/voting/voting_vm.dart';
import 'package:lueesa_app/ui/views/voting/widgets/vote_post.dart';
import 'package:lueesa_app/ui/widgets/l_auth_textfield.dart';
import 'package:lueesa_app/ui/widgets/l_get_button.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/l_textfield.dart';

class VotingScreen extends StatelessWidget {
  final User user;
  const VotingScreen({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => VotingViewModel(),
        builder: (context, model, _) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: TextWidget(
                    text: "Voting as ${user.displayName!.split(" ").first}",
                    fontsize: 25.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(user.photoURL!),
                      ),
                    )
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LTextField(
                            label: 'Registration number',
                            maxLines: 1,
                            hintText: "Type your reg number",
                            textCtr: model.regCtr),
                        ...electionInfo.mapIndexed((index, e) => VotePost(
                              post: e["post"],
                              votees: e["nominees"],
                              index: index,
                            )),
                        //Submit button
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: SmallButton(
                              text: "Submit",
                              onTap: () {
                                model.submit(context, user.email!, user.uid);
                              }),
                        )
                      ],
                    ),
                  ),
                )),
          );
        });
  }
}
