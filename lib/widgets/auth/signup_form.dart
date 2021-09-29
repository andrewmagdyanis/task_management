import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_management/widgets/auth/rounded_input_field.dart';
import 'package:task_management/widgets/auth/rounded_password_field.dart';
import '../../constants.dart';
import '../dialogs.dart';
import '../rounded_button.dart';

class SignUpForm extends StatefulWidget {
  final Future<bool> Function({
    String? userName,
    File? image,
    required String email,
    required String password,
    required bool isLogin,
    required BuildContext context,
    String? phone,
  }) authenticate;
  final TabController tabController;

  SignUpForm({required this.authenticate, required this.tabController});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late String _userName;
  late String _email;
  late String _password;
  late String _confirmedPassword;
  late String _phone;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _passController = TextEditingController();
  final auth = FirebaseAuth.instance;

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
        userName: _userName.trim(),
        email: _email.trim(),
        password: _password.trim(),
        isLogin: false,
        context: context,
        phone: _phone,
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
      widget.tabController.animateTo(0);
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
                labelText: "User Name",
                validator: (value) {
                  if (value!.isEmpty || value.length < 4) {
                    print('please enter 4 character or more as user name');
                    return 'please enter 4 character or more as user name';
                  }
                  return null;
                },
                onSave: (value) {
                  _userName = value!;
                },
              ),


              RoundedInputField(
                key: ValueKey('Phone'),
                labelText: 'Phone',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty || value.length < 11) {
                    print('please enter 11 character as your phone number');
                    return 'please enter 11 character as your phone number';
                  }
                  return null;
                },
                onSave: (value) {
                  _phone = value!;
                },
              ),


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
              RoundedPasswordField(
                labelText: 'Confirm password',
                onChanged: (value) {
                  setState(() {
                    _confirmedPassword = value;
                    print(_confirmedPassword);
                  });
                },
                validator: (value) {
                  if (value != _passController.text) {
                    print('please enter the same password');

                    return 'please enter the same password';
                  }
                  return null;
                },
                onSave: (value) {
                  _confirmedPassword = value!;
                },
              ),
              (_isLoading)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : RoundedButton(
                      text: "SIGNUP",
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
