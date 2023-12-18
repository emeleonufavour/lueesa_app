import 'package:flutter/material.dart';

class LDimensions {
  LDimensions._();

  //responsive dimensions
  static double height(double value, BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return (height * value);
  }

  static double width(double value, BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return (width * value);
  }
}
