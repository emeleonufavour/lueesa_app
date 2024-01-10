import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lueesa_app/ui/views/pq_view/image_view/image_view_screen.dart';

import '../style/app_colors.dart';
import '../utilities/l_text.dart';

class ImageBox extends StatefulWidget {
  final String name;
  final String imageUrl;
  bool isDownloading;
  double downloadProgress;
  final void Function()? download;
  ImageBox(
      {required this.name,
      required this.imageUrl,
      required this.download,
      required this.isDownloading,
      required this.downloadProgress,
      super.key});

  @override
  State<ImageBox> createState() => _ImageBoxState();
}

class _ImageBoxState extends State<ImageBox> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          height: 75.h,
          width: double.maxFinite,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  widget.imageUrl,
                  width: 70.w,
                  height: 70.h,
                  fit: BoxFit.cover,
                )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //question name
                    TextWidget(text: widget.name),

                    Row(children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ViewImageScreen(
                                  name: widget.name,
                                  imageUrl: widget.imageUrl)));
                        },
                        child: const TextWidget(
                          text: "View",
                          color: AppColor.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(25.w),
                      widget.isDownloading
                          ? CircularProgressIndicator(
                              strokeWidth: 2.w,
                            )
                          : GestureDetector(
                              onTap: widget.download,
                              child: const TextWidget(
                                text: "Download",
                                color: AppColor.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ]),
                  ],
                ),
              ),
            )
          ])),
    );
  }
}
