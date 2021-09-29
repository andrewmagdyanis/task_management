import 'dart:ui';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../logoIcon.dart';

class AuthAppLogo extends StatelessWidget {
  const AuthAppLogo({
    Key? key,
    required this.w,
    required this.h,
  }) : super(key: key);

  final double w;
  final double h;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: metalicGolden,
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            metalicGolden,
            metalicGolden,
            metalicGolden,
            metalicGolden,
            metalicGolden,
            metalicGolden,
            metalicGolden,
            metalicGolden,
            metalicGolden,
            metalicGolden,

            metalicGolden.withOpacity(0.2),
            metalicGolden.withOpacity(0.2),
            Colors.red,

          ],
        ),
      ),
      height: w * 0.42,
      width: w * 0.42,
      padding: EdgeInsets.all(w * 0.035),
      // child: Hero(
      //   tag: 'logo',
      //   child: LogoAsIcon(
      //     iconLocation: 'assets/icons/splashSmall.png',
      //   ),
      // ),
    );
  }
}
