import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ViewImageScreen extends StatelessWidget {
  final String name;
  final String imageUrl;
  const ViewImageScreen(
      {required this.name, required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Image.network(
            imageUrl,
            width: double.maxFinite,
            height: size.height * 0.6,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
