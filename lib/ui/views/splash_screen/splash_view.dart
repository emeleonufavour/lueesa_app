import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lueesa_app/app/routing/screen_path.dart';
import 'package:lueesa_app/ui/views/home/home.dart';
import 'package:stacked/stacked.dart';

import '../auth/login/login_view.dart';
import 'splash_vm.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _HomeViewState();
}

class _HomeViewState extends State<SplashScreenView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 4500), () {
      context.go(ScreenPath.login);
    });
    return ViewModelBuilder.nonReactive(
        viewModelBuilder: () => SplashScreenViewModel(),
        onViewModelReady: (viewModel) {
          viewModel.controller = AnimationController(
              vsync: this, duration: const Duration(seconds: 4));
          viewModel.controller.forward();
        },
        onDispose: (viewModel) {
          viewModel.controller.dispose();
        },
        builder: (context, model, _) => Scaffold(
                body: Center(
              child: AnimatedBuilder(
                  animation: model.controller,
                  builder: (context, child) {
                    return Stack(children: [
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeInOut,
                        left: MediaQuery.sizeOf(context).width * 0.3,
                        top: model.controller.value < 0.8
                            ? 300 - 100 * model.controller.value
                            : -200,
                        child: Center(
                            child: Transform.rotate(
                          angle: 2 * 3.14 * model.controller.value,
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
            )));
  }
}
