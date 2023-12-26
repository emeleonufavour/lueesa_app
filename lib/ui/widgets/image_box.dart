import 'package:flutter/material.dart';

import '../style/app_colors.dart';
import '../utilities/l_text.dart';

class ImageBox extends StatelessWidget {
  final String name;
  final String imageUrl;
  final void Function()? download;
  const ImageBox(
      {required this.name,
      required this.imageUrl,
      required this.download,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
          height: 75,
          width: double.maxFinite,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Image.network(imageUrl),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //question name
                    TextWidget(text: name),
                    GestureDetector(
                      onTap: download,
                      child: const TextWidget(
                        text: "Download",
                        color: AppColor.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ])),
    );
  }
}
