import 'dart:ui';

import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  final String assetImageLocation;

  Background({
    Key?key,
    required this.child,
    required this.assetImageLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(assetImageLocation),
            fit: BoxFit.fill,
          ),
        ),
        child: child,
//         child: Stack(
//           alignment: Alignment.center,
//           children: <Widget>[
//             /*
//             Positioned(
//               top: 0,
//               left: 0,
//               child: Image.asset(
//                 "assets/images/background10.jpg",
//                 width: displayWidth(context) ,
//               ),
//             ),
// */
//             child,
//           ],
//         ),
      ),
      //bottomNavigationBar: Container(height: 50,color: Colors.red,),
      //bottomSheet: Container(height: 50,color: Colors.green,),
    );
  }
}
