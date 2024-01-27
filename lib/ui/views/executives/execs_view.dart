import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:lueesa_app/ui/utilities/l_text.dart';
import 'package:stacked/stacked.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

import '../../style/app_assets.dart';
import 'execs_vm.dart';

class ExecsView extends StatelessWidget {
  const ExecsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => ExecsViewModel(),
        onViewModelReady: (viewModel) async {
          await viewModel.getExecsList(context);
        },
        builder: (context, model, _) {
          return Scaffold(
              body: ExecsBody(
            model: model,
          ));
        });
  }
}

class ExecsBody extends StatelessWidget {
  ExecsViewModel model;
  ExecsBody({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    if (model.isBusy) {
      return Center(
        child: Lottie.asset("assets/lotties/hand-loading.json",
            animate: true, repeat: true),
      );
    }
    if (model.execs_list.isEmpty) {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppAssets.emptyBox(),
          const Gap(12),
          const TextWidget(text: "Nothing to see here yet")
        ],
      ));
    }
    return TableView.builder(
        diagonalDragBehavior: DiagonalDragBehavior.free,
        columnCount: 4,
        rowCount: 4,
        columnBuilder: (index) {
          return TableSpan(
            foregroundDecoration: const TableSpanDecoration(
              border: TableSpanBorder(
                trailing: BorderSide(width: 10, color: Colors.white),
              ),
            ),
            extent: const FractionalTableSpanExtent(0.9),
            onEnter: (_) => log('Entered column $index'),
            cursor: SystemMouseCursors.contextMenu,
          );
        },
        rowBuilder: (index) {
          return const TableSpan(
            // backgroundDecoration: TableSpanDecoration(
            //   border: TableSpanBorder(
            //     trailing: BorderSide(width: 10, color: Colors.white),
            //   ),
            // ),
            foregroundDecoration: TableSpanDecoration(
              border: TableSpanBorder(
                trailing: BorderSide(width: 10, color: Colors.white),
              ),
            ),
            //extent: FixedTableSpanExtent(65),
            extent: FractionalTableSpanExtent(0.4),
            cursor: SystemMouseCursors.click,
          );
        },
        cellBuilder: (context, vicinity) {
          if (vicinity.column == 0 && vicinity.row == 0) {
            return Image.network(model.execs_list[0]["downloadUrl"]!,
                fit: BoxFit.cover, width: 1000.0);
          }
          if (vicinity.column == 0 && vicinity.row == 1) {
            return Image.network(model.execs_list[1]["downloadUrl"]!,
                fit: BoxFit.cover, width: 1000.0);
          }
          if (vicinity.column == 0 && vicinity.row == 2) {
            return Image.network(model.execs_list[2]["downloadUrl"]!,
                fit: BoxFit.cover, width: 1000.0);
          }
          if (vicinity.column == 0 && vicinity.row == 3) {
            return Image.network(model.execs_list[3]["downloadUrl"]!,
                fit: BoxFit.cover, width: 1000.0);
          }
          if (vicinity.column == 1 && vicinity.row == 0) {
            return Image.network(model.execs_list[4]["downloadUrl"]!,
                fit: BoxFit.cover, width: 1000.0);
          }
          if (vicinity.column == 1 && vicinity.row == 1) {
            return Image.network(model.execs_list[5]["downloadUrl"]!,
                fit: BoxFit.cover, width: 1000.0);
          }
          if (vicinity.column == 1 && vicinity.row == 2) {
            return Image.network(model.execs_list[6]["downloadUrl"]!,
                fit: BoxFit.cover, width: 1000.0);
          }
          if (vicinity.column == 1 && vicinity.row == 3) {
            return Image.network(model.execs_list[7]["downloadUrl"]!,
                fit: BoxFit.cover, width: 1000.0);
          }
          if (vicinity.column == 2 && vicinity.row == 0) {
            return Image.network(model.execs_list[8]["downloadUrl"]!,
                fit: BoxFit.cover, width: 1000.0);
          }
          if (vicinity.column == 2 && vicinity.row == 1) {
            return Image.network(model.execs_list[9]["downloadUrl"]!,
                fit: BoxFit.cover, width: 1000.0);
          }
          if (vicinity.column == 2 && vicinity.row == 2) {
            return Image.network(model.execs_list[10]["downloadUrl"]!,
                fit: BoxFit.cover, width: 1000.0);
          }
          if (vicinity.column == 2 && vicinity.row == 3) {
            return Image.network(model.execs_list[11]["downloadUrl"]!,
                fit: BoxFit.cover, width: 1000.0);
          }
          if (vicinity.column == 3 && vicinity.row == 0) {
            return Image.network(model.execs_list[12]["downloadUrl"]!,
                fit: BoxFit.cover, width: 1000.0);
          }
          if (vicinity.column == 3 && vicinity.row == 1) {
            return Image.network(model.execs_list[13]["downloadUrl"]!,
                fit: BoxFit.cover, width: 1000.0);
          }
          if (vicinity.column == 3 && vicinity.row == 2) {
            return Image.network(model.execs_list[14]["downloadUrl"]!,
                fit: BoxFit.cover, width: 1000.0);
          }
          if (vicinity.column == 3 && vicinity.row == 3) {
            return Image.network(model.execs_list[15]["downloadUrl"]!,
                fit: BoxFit.cover, width: 1000.0);
          }
          // if (vicinity.column == 3 && vicinity.row == 1) {
          //   return Image.network(model.execs_list[16]["downloadUrl"]!,
          //       fit: BoxFit.cover, width: 1000.0);
          // }

          // return Image.asset("assets/favour.jpeg",
          //     fit: BoxFit.cover, width: 1000.0);
          return Container();
        });
  }
}
