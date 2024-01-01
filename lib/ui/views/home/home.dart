import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lueesa_app/app/routing/screen_path.dart';
import 'package:lueesa_app/ui/utilities/l_text.dart';
import 'package:lueesa_app/ui/views/home/home_vm.dart';
import 'package:stacked/stacked.dart';

import '../../style/app_assets.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => HomeViewModel(),
        builder: ((context, viewModel, child) => Scaffold(
              appBar: AppBar(),
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: AppAssets.lueesaLogo(100))),
                    ListTile(
                      leading: const Icon(
                        Icons.image,
                        color: Colors.black,
                      ),
                      title: const TextWidget(
                        text: "Upload image",
                        fontWeight: FontWeight.bold,
                      ),
                      onTap: () => viewModel.goToPastQuestionsUpload(),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.question_mark,
                        color: Colors.black,
                      ),
                      title: const TextWidget(
                        text: "Past Questions",
                        fontWeight: FontWeight.bold,
                      ),
                      onTap: () => viewModel.goToPastQuestionsView(),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.table_chart,
                        color: Colors.black,
                      ),
                      title: const TextWidget(
                        text: "Time table",
                        fontWeight: FontWeight.bold,
                      ),
                      onTap: () => viewModel.goToTimeTable(),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.subject,
                        color: Colors.black,
                      ),
                      title: const TextWidget(
                        text: "Course Information",
                        fontWeight: FontWeight.bold,
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      title: const TextWidget(
                        text: "Executives",
                        fontWeight: FontWeight.bold,
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              body: Center(
                child: Column(
                  children: [],
                ),
              ),
            )));
  }
}
