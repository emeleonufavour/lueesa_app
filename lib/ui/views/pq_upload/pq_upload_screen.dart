import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PastQuestionUploadScreen extends StatelessWidget {
  const PastQuestionUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(onPressed: () {}, icon: const Icon(Icons.upload)),
      ),
    );
  }
}
