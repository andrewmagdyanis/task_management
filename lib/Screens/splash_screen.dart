import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final String text;

  SplashScreen({
    this.text = 'Loading .... ',
  });

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(text),
      ),
    );
  }
}
