import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';
import 'test_vm.dart';

class TestScreen extends StatelessWidget {
  TestScreen({super.key});
  final GlobalKey widgetKey = GlobalKey();

  void getPositionAndPrint(TestViewModel model) {
    // Find the RenderBox for the widget using the GlobalKey
    RenderBox renderBox =
        widgetKey.currentContext!.findRenderObject() as RenderBox;

    // Get the global position of the widget
    Offset globalPosition = renderBox.localToGlobal(Offset.zero);

    model.boxPosition = globalPosition;

    log('Widget position in screen coordinates: $globalPosition');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => TestViewModel(),
        builder: (context, model, _) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          getPositionAndPrint(model);
                        },
                        onLongPress: () {
                          log("Touched");
                          model.touched = true;
                          getPositionAndPrint(model);
                        },
                        onLongPressCancel: () {
                          log("Touch canceled");
                        },
                        onLongPressEnd: (details) {
                          // Find the RenderBox for the widget using the GlobalKey

                          log("Position of yellow box is ${model.boxPosition}");
                          // model.boxPosition = details.globalPosition;
                          // log('Long press ended and happened at this global postion ==> ${details.globalPosition}');
                          log("X position ==> ${model.boxPosition!.dx}");
                          log("Y position ==> ${model.boxPosition!.dy}");
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: AnimatedContainer(
                            curve: Curves.easeIn,
                            key: widgetKey,
                            height: model.touched ? 100 : 75,
                            width: model.touched ? 100 : 75,
                            decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(20)),
                            duration: const Duration(seconds: 1),
                          ).animate(target: model.touched ? 1 : 0).callback(
                              duration: 1100.milliseconds,
                              callback: (_) {
                                model.show = true;
                              }),
                        ),
                      ),
                      if (model.boxPosition != null)
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 500),
                          opacity: model.show ? 1 : 0,
                          child: Container(
                            height: 120,
                            width: 100,
                            margin: EdgeInsets.only(
                                left: model.boxPosition!.dx - 35,
                                top: model.boxPosition!.dy + 65),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(
                                    model.touched ? 10 : 0)),
                          ),
                        ).animate().scaleXY(
                            begin: 0,
                            end: 2,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.bounceIn),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class AppBoxes extends StatelessWidget {
  const AppBoxes({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [],
    );
  }
}
