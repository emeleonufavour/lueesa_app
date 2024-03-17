import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lueesa_app/ui/utilities/l_text.dart';
import 'package:lueesa_app/ui/views/voting/voting_vm.dart';
import 'package:lueesa_app/ui/views/voting/widgets/vote_post.dart';
import 'package:lueesa_app/ui/widgets/l_get_button.dart';
import 'package:stacked/stacked.dart';

class VotingScreen extends StatelessWidget {
  const VotingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => VotingViewModel(),
        builder: (context, model, _) {
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: TextWidget(
                  text: "Vote Your Excos",
                  fontsize: 25.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...electionInfo.map((e) =>
                          VotePost(post: e["post"], votees: e["nominees"])),
                      //Submit button
                      SmallButton(text: "Submit", onTap: () {})
                    ],
                  ),
                ),
              ));
        });
  }
}
