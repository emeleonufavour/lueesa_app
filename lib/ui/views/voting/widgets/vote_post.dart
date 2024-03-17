import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lueesa_app/ui/views/voting/widgets/votee_box.dart';

import '../../../utilities/l_text.dart';

class VotePost extends StatefulWidget {
  String post;
  List<String> votees;

  VotePost({required this.post, required this.votees, super.key});

  @override
  State<VotePost> createState() => _VotePostState();
}

class _VotePostState extends State<VotePost> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: widget.post,
          fontsize: 20.sp,
        ),
        Gap(10.h),
        ListView.builder(
            shrinkWrap: true,
            itemCount: widget.votees.length,
            itemBuilder: (context, index) {
              return VoteeBox(
                  name: widget.votees[index],
                  isSelected: selectedIndex == index ? true : false,
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  });
            })
      ],
    );
  }
}
