import 'package:flutter/material.dart';
import 'package:task_management/helpers/sizes_helpers.dart';
import '../../constants.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget? child;
  final double? widthRatio;
  final double? heightRatio;

  TextFieldContainer({
    Key? key,
    this.heightRatio,
    this.widthRatio=0.8,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.symmetric(
          vertical: displayHeight(context) / 140, horizontal: displayWidth(context) / 20),
      padding: EdgeInsets.symmetric(
          horizontal: displayWidth(context) / 25, ),
      width: displayWidth(context) * widthRatio!,
      height: heightRatio==null?65:(displayHeight(context) * heightRatio!),
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(displayHeight(context) / 30),
      ),
      child: child,
    );
  }
}
