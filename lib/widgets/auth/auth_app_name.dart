import 'package:flutter/material.dart';

import '../../constants.dart';

class AuthAppName extends StatelessWidget {
  const AuthAppName({
    Key? key,
    required this.w,
    required this.h,
  }) : super(key: key);

  final double w;
  final double h;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w / 3,
      height: h / 15,
      child: FittedBox(
        child: const Text(
          "T M S",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: kPrimaryLightColor,
          ),
          softWrap: true,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
