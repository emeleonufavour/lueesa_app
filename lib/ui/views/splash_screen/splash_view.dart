import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lueesa_app/ui/views/home/home.dart';

import '../auth/login/login_view.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _HomeViewState();
}

class _HomeViewState extends State<SplashScreenView>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    _controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 4500), () {
      Navigator.push(context,
          MaterialPageRoute(builder: ((context) => const LoginView())));
    });
    return Scaffold(
        body: Center(
      child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
                left: MediaQuery.sizeOf(context).width * 0.3,
                top: _controller.value < 0.8
                    ? 300 - 100 * _controller.value
                    : -200,
                child: Center(
                    child: Transform.rotate(
                  angle: 2 * 3.14 * _controller.value,
                  origin: Offset(0.5, 0.5),
                  child: SvgPicture.asset(
                    'assets/svg/luessaLogo.svg', // Replace with your SVG asset path
                    width: 200, // Adjust width as needed
                    height: 200, // Adjust height as needed
                  ),
                )),
              ),
            ]);
          }),
    ));
  }
}
