import 'dart:io';

import 'package:flutter/material.dart';
import 'package:task_management/widgets/auth/signup_form.dart';

import 'login_form.dart';

class AuthTabBarView extends StatefulWidget {
  const AuthTabBarView({
    Key? key,
    required this.tabController,
    required this.w,
    required this.h,
    required this.authenticate,
  }) : super(key: key);

  final TabController tabController;
  final w;
  final h;
  final Future<bool> Function({
     String? userName,
     File? image,
    required String email,
    required String password,
    required bool isLogin,
    required BuildContext context,
     String? phone,
  }) authenticate;

  @override
  _AuthTabBarViewState createState() => _AuthTabBarViewState();
}

class _AuthTabBarViewState extends State<AuthTabBarView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.h * 0.5,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: TabBarView(
            controller: widget.tabController,
            physics: ScrollPhysics(parent: BouncingScrollPhysics()),
            children: [
              LoginForm(
                authenticate: widget.authenticate,
                tabController: widget.tabController,
              ),
              SignUpForm(
                authenticate: widget.authenticate,
                tabController: widget.tabController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
