import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../logoIcon.dart';

class AuthAppLogo extends StatefulWidget {
  const AuthAppLogo({
    Key? key,
    required this.w,
    required this.h,
  }) : super(key: key);

  final double w;
  final double h;

  @override
  _AuthAppLogoState createState() => _AuthAppLogoState();
}

class _AuthAppLogoState extends State<AuthAppLogo>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 5000),
    );
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (_, child) {
          return Container(
            transformAlignment: Alignment.center,
            transform: Matrix4.rotationZ(animationController.value * 2 * pi),
            child: Container(
              transformAlignment: Alignment.center,
              transform: Matrix4.rotationY(animationController.value * 4 * pi),
              child: Container(
                transformAlignment: Alignment.center,
                transform:
                    Matrix4.rotationX(animationController.value  * pi),
                child: Container(
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
                  height: widget.w * 0.42,
                  width: widget.w * 0.42,
                  padding: EdgeInsets.all(widget.w * 0.035),
                  // child: Hero(
                  //   tag: 'logo',
                  //   child: LogoAsIcon(
                  //     iconLocation: 'assets/icons/splashSmall.png',
                  //   ),
                  // ),
                ),
              ),
            ),
          );

          return RotationTransition(
            turns: Tween(begin: 0.0, end: 1.0).animate(animationController),
            child: Container(
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
              height: widget.w * 0.42,
              width: widget.w * 0.42,
              padding: EdgeInsets.all(widget.w * 0.035),
              child: Text('>><<'),
              // child: Hero(
              //   tag: 'logo',
              //   child: LogoAsIcon(
              //     iconLocation: 'assets/icons/splashSmall.png',
              //   ),
              // ),
            ),
          );
        });
  }
}
