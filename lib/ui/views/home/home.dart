import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lueesa_app/app/routing/screen_path.dart';
import 'package:lueesa_app/ui/views/home/home_vm.dart';
import 'package:stacked/stacked.dart';

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
                    const DrawerHeader(
                        decoration: BoxDecoration(color: Colors.blue),
                        child: Text("Header")),
                    ListTile(
                      title: const Text("Upload image"),
                      onTap: () => context.go(ScreenPath.pastquestion),
                    ),
                    ListTile(
                      title: const Text("Past Questions"),
                    ),
                    ListTile(
                      title: const Text("Time table"),
                    ),
                    ListTile(
                      title: const Text("Course Information"),
                    ),
                    ListTile(
                      title: const Text("LUEESA Excos"),
                    ),
                  ],
                ),
              ),
              body: Center(
                child: Column(
                  children: [
                    if (viewModel.imgFile != null)
                      Image.file(viewModel.imgFile!),
                    IconButton(
                        onPressed: () => viewModel.uploadToFirebase(),
                        icon: const Icon(Icons.upload)),
                  ],
                ),
              ),
            )));
  }
}
