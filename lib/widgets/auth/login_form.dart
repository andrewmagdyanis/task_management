import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_management/widgets/auth/rounded_input_field.dart';
import 'package:task_management/widgets/auth/rounded_password_field.dart';
import '../../constants.dart';
import '../dialogs.dart';
import '../rounded_button.dart';

class LoginForm extends StatefulWidget {
  final Future<bool> Function({
    String? userName,
    File? image,
    required String email,
    required String password,
    required bool isLogin,
    required BuildContext context,
    String? phone,
  }) authenticate;
  final tabController;

  LoginForm({required this.authenticate, this.tabController});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late String _email;
  late String _password;
  late String _confirmedPassword;
  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;

  TextEditingController _passController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _passController.dispose();
    super.dispose();
  }

  Future<void> trySubmit() async {
    setState(() {
      _isLoading = true;
    });
    bool isDone = false;
    bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      isDone = await widget.authenticate(
        email: _email.trim(),
        password: _password.trim(),
        isLogin: true,
        context: context,
      );
      print('isDone: ' + isDone.toString());
    } else {
      print('Is not valid');
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Please check your inputs'),
              title: Text('Not valid inputs'),
              actions: [
                RoundedButton(
                  text: 'Ok',
                  press: () {
                    Navigator.of(context).pop();
                  },
                  heightRatio: 0.06,
                  widthRatio: 0.35,
                ),
              ],
            );
          });
    }
    if (auth.currentUser != null && isDone) {
      print('current user:' + auth.currentUser!.displayName!);
      if (!auth.currentUser!.emailVerified) {
        print('please verify your email and then Login');
        Dialogs().showVerificationAlertDialog(context, () async {
          await FirebaseAuth.instance.currentUser!.sendEmailVerification();
        });
      }
    }
    setState(() {
      _isLoading = false; //stop the spinning button
    });
    print('Valid:' + isValid.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
      margin: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 4),
      //height: double.infinity,
      decoration: BoxDecoration(
        // color: Colors.white70.withOpacity(0.3),
        border: Border.all(width: 1, color: Colors.transparent),
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: SingleChildScrollView(
        physics: ScrollPhysics(parent: BouncingScrollPhysics()),
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            // color: Colors.black54.withOpacity(0.35),

            border: Border.all(width: 1, color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Form(
            key: _formKey,
            child: Column(children: [
              RoundedInputField(
                labelText: "Email",
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    print('please enter non empty email');
                    return 'please enter non empty email';
                  } else if (!value.contains('@') || !value.contains('.com')) {
                    print('please enter valid email address');
                    return 'please enter valid email address';
                  }
                  return null;
                },
                onSave: (value) {
                  _email = value!;
                },
              ),
              RoundedPasswordField(
                labelText: 'Password',
                controller: _passController,
                validator: (value) {
                  if (value!.isEmpty) {
                    print('please enter non empty password');
                    return 'please enter non empty password';
                  } else if (value.length < 6) {
                    print('please enter stronger password');
                    return 'please enter stronger password';
                  }
                  return null;
                },
                onSave: (value) {
                  _password = value!;
                },
              ),
              (_isLoading)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : RoundedButton(
                      text: "Login",
                      color: kPrimaryColor,
                      press: trySubmit,
                      heightRatio: 0.065,
                      widthRatio: 0.3),
            ]),
          ),
        ),
      ),
    );
  }
}
