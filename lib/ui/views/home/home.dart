import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text("Header")),
            ListTile(
              title: const Text("Upload image"),
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
        child: Text("Home page"),
      ),
    );
  }
}
