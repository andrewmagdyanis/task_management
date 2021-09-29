import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_management/widgets/auth/rounded_input_field.dart';
import 'package:task_management/widgets/auth/rounded_password_field.dart';

import '../dialogs.dart';
import '../rounded_button.dart';

class AuthForm extends StatefulWidget {
  final Future<bool> Function({
    String? userName,
    File image,
    String email,
    String password,
    bool isLogin,
    BuildContext context,
    String team,
    String church,
    String phone,
  }) authenticate;

  AuthForm({
    required this.authenticate,
  });

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool _isLogin = true;
  bool _isLoading = false;

  late String _userName;
  late String _email;
  late String _password;
  late String _confirmPassword;
  late File pickedImage;
  late String _phone;
  late String _church;
  late String _team;

  void passImage(File image) {
    pickedImage = image;
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final auth = FirebaseAuth.instance;
    TextEditingController passController = TextEditingController();

    Future<void> trySubmit() async {
      setState(() {
        _isLoading = true;
      });
      // if (pickedImage == null && !_isLogin) {
      //   print('Picked image is null in signup form');
      //   showDialog(
      //       context: context,
      //       builder: (context) {
      //         return AlertDialog(
      //           content: Text('Please choose an image before continue'),
      //           title: Text('No Image found'),
      //           actions: [
      //             RoundedButton(
      //               text: 'Ok',
      //               heightRatio: 0.05,
      //               press: () {
      //                 Navigator.of(context).pop();
      //               },
      //             ),
      //           ],
      //         );
      //       });
      // }
      bool isDone = false;
      bool isValid = _formKey.currentState!.validate();
      if (isValid) {
        _formKey.currentState!.save();
        isDone = await widget.authenticate(
          userName: (_isLogin) ? null : _userName.trim(),
          image: pickedImage,
          email: _email.trim(),
          password: _password.trim(),
          isLogin: _isLogin,
          context: context,
          team: _team,
          church: _church,
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
      }
      setState(() {
        _isLoading = false; //stop the spinning button
        _isLogin = true; //go to login page
      });
      print('Valid:' + isValid.toString());
    }

    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
      margin: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 20),
      //height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black54.withOpacity(0.35),
        border: Border.all(width: 1, color: Colors.transparent),
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            // color: Colors.black54.withOpacity(0.35),

            border: Border.all(width: 1, color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                // if (!_isLogin)
                //   UserImagePicker(
                //     passImage: passImage,
                //   ),
                if (!_isLogin)
                  RoundedInputField(
                    key: ValueKey('User Name'),
                    labelText: 'User Name',
                    keyboardType: TextInputType.text,
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
                if (!_isLogin)
                  RoundedInputField(
                    key: ValueKey('Church'),
                    labelText: 'Church',
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 4) {
                        print('please enter 4 character or more as church');
                        return 'please enter 4 character or more as church';
                      }
                      return null;
                    },
                    onSave: (value) {
                      _church = value!;
                    },
                  ),
                if (!_isLogin)
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
                if (!_isLogin)
                  RoundedInputField(
                    key: ValueKey('Team'),
                    labelText: 'Team',
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 3) {
                        print('please enter 3 character as your team name');
                        return 'please enter 3 character as your team name';
                      }
                      return null;
                    },
                    onSave: (value) {
                      _phone = value!;
                    },
                  ),
                RoundedInputField(
                  key: ValueKey('E-mail'),
                  labelText: 'E-mail',
                  keyboardType: TextInputType.emailAddress,
                  icon: Icons.email,
                  validator: (value) {
                    if (value!.isEmpty) {
                      print('please enter non empty email');
                      return 'please enter non empty email';
                    } else if (!value.contains('@') ||
                        !value.contains('.com')) {
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
                  key: ValueKey('Password'),
                  labelText: 'Password',
                  keyboardType: TextInputType.text,
                  controller: passController,
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
                if (!_isLogin)
                  RoundedPasswordField(
                    key: ValueKey('Re-Enter Password'),
                    labelText: 'Re-Enter Password',
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value != passController.text) {
                        print('please enter the same password');

                        return 'please enter the same password';
                      }
                      return null;
                    },
                    onSave: (value) {
                      _confirmPassword = value!;
                    },
                  ),
                (_isLoading)
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : RaisedButton(
                        child: Text((_isLogin) ? 'Login' : 'Sign Up'),
                        onPressed: trySubmit,
                        textTheme: ButtonTextTheme.primary,
                        //colorBrightness: Brightness.dark,
                      ),
                FittedBox(
                  child: FlatButton(
                      colorBrightness: Brightness.dark,
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(
                        (_isLogin)
                            ? 'Sign up instead'
                            : 'I already have an Account',
                        style: TextStyle(fontSize: 18),
                      )),
                ),
                // FlatButton(
                //     onPressed: () async {
                //       String dt =
                //           'https://play.google.com/store/apps/details?id=com.comic.comicer';
                //       bool isInstalled = await DeviceApps.isAppInstalled('com.comic.comicer');
                //       if (isInstalled != false) {
                //         print('Already installed');
                //         DeviceApps.openApp('com.comic.comicer');
                //       } else {
                //         print('Not installed');
                //         String url = dt;
                //         if (await canLaunch(url))
                //           await launch(url);
                //         else
                //           throw 'Could not launch $url';
                //       }
                // }, child: Text('Open comicer')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
