import 'package:flutter/material.dart';

import '../../constants.dart';

class AuthTabBar extends StatelessWidget {
  const AuthTabBar({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 4, right: 4, top: 2, bottom: 2),
      margin: const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 0),
      decoration: BoxDecoration(
        color: Colors.white70.withOpacity(0.6),
        border: Border.all(width: 1, color: Colors.transparent),
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: TabBar(
          controller: tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: kPrimaryColor.withOpacity(0.6)),
          labelColor: Colors.white,
          indicatorColor: white,
          unselectedLabelColor: Colors.black,
          labelStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          unselectedLabelStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24),
          tabs: [
            FittedBox(
              child: Text(
                'Login',
                // style: TextStyle(color: white),
              ),
            ),
            FittedBox(
              child: Text(
                'Sign up',
                // style: TextStyle(color: Colors.grey),
              ),
            ),
          ]),
    );
  }
}
