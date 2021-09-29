import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';

class LogoAsIcon extends StatelessWidget {
  final double height;
  final double width;
  final Color? color;
  final Function()? press;
  final String iconLocation;
  final FilterQuality filterQuality;
  final BoxFit fit;

  LogoAsIcon({
    this.height = 80,
    this.width = 80,
    this.color,
    this.press,
    required this.iconLocation,
    this.filterQuality= FilterQuality.high,
    this.fit= BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: height,
      width: width,
      child: InkWell(
        onTap: press,
        splashColor: kPrimaryLightColor,
        child: (Padding(
          padding: EdgeInsets.only(left: 2, right: 2),
          child: FittedBox(
            child: Center(
              child: Container(
                //height: size,
                child: Image.asset(
                  iconLocation,
                  height: height,
                  width: width,
                  color: color,
                  fit:fit,
                  filterQuality: filterQuality,
                ),
              ),
            ),
          ),
        )

            /*
        ImageIcon(
          AssetImage('assets/icons/comicerLogos/comicerLeftLogo512.png'),
          color:color ,
          size: size,
        ),
            */
        ),
      ),
    );
  }
}
