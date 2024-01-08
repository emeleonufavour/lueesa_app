import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class AppAssets {
  static lueesaLogo(double size) => SvgPicture.asset(
        "assets/svg/luessaLogo.svg",
        height: size,
        width: size,
      );
  static Widget waitingHand([bool? animate, bool? repeat]) =>
      Lottie.asset("assets/lotties/hand-loading.json",
          animate: animate ?? true, repeat: repeat ?? true);

  static Widget emptyBox([bool? animate, bool? repeat]) => Lottie.asset(
        "assets/lotties/waiting-box.json",
        animate: animate ?? true,
        repeat: repeat ?? true,
        height: 200,
      );
}
