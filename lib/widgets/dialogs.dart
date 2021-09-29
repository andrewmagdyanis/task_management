import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:task_management/widgets/rounded_button.dart';
import '../constants.dart';
import '../helpers/sizes_helpers.dart';
import 'logoIcon.dart';

class Dialogs {
  final String dialogText;
  final bool barrierDismissibleFlag;

  Dialogs({
    Key? key,
    this.dialogText = 'Loading',
    this.barrierDismissibleFlag = false,
  });

  Future<dynamic> showsSimpleDialog(
    BuildContext context, {
    String dialogText = 'simple dialog',
    Color color = Colors.white70,
  }) {
    return showDialog(
      barrierDismissible: barrierDismissibleFlag,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: color,
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            )
          ],
          content: new Row(
            children: [
              Flexible(
                  child: Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Text(dialogText))),
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> showAlertDialog(
    BuildContext context, {
    String dialogText = 'Loading',
    Color color = Colors.white70,
  }) {
    return showDialog(
      barrierDismissible: barrierDismissibleFlag,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: color,
          content: new Row(
            children: [
              CircularProgressIndicator(),
              Container(
                  margin: EdgeInsets.only(left: 5), child: Text(dialogText)),
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> showErrorDialog(
    BuildContext context, {
    String errorStatement = 'error',
    Color color = Colors.white70,
    String closeReturnPageName = '/',
    numberOfPops = 1,
  }) {
    AlertDialog alert = AlertDialog(
      title: Text('Error'),
      backgroundColor: color,
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            if (closeReturnPageName == '/') {
              // if no given route
              for (int i = 0; i < numberOfPops; i++) {
                Navigator.of(context).pop();
              }
            } else {
              Navigator.of(context).popUntil((route) {
                return route.isFirst;
              });
              Navigator.pushNamed(context, closeReturnPageName);
            }

            /*
            Navigator.of(context).popUntil((route) {
              return Navigator.canPop(context) == false;
            });
            Navigator.pushReplacementNamed(context, closeReturnPageName);
          */
          },
          child: Text('Close'),
        )
      ],
      content: new Row(
        children: [
          //Icon(Icons.error),
          Flexible(
            child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  errorStatement,
                  maxLines: 10,
                  softWrap: true,
                  style: TextStyle(color: Colors.red),
                )),
          ),
        ],
      ),
    );

    return showDialog(
      barrierDismissible: barrierDismissibleFlag,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: displayHeight(context),
          width: displayWidth(context),
          child: alert,
        );
      },
    );
  }

  Future<dynamic> showFullScreenDialog(BuildContext context,
      {String dialogText = 'dialogText',
      Color? textColor,
      Color? backgroundColor}) {
    AlertDialog alert = AlertDialog(
      backgroundColor: backgroundColor,
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                dialogText,
                style: TextStyle(color: textColor, fontSize: 14),
              )),
        ],
      ),
    );
    return showGeneralDialog(
      barrierDismissible: barrierDismissibleFlag,
      context: context,
      transitionDuration: Duration(seconds: 1),
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> animation2) {
        return Center(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: backgroundColor,
            child: (Text('hereeee')),
          ),
        );
      },
    );
  }

  Future<dynamic> showOnWillUpDialog(
    BuildContext context, {
      logoPath,
    String title = '',
    String content = '',
    Color? textColor,
    Color? backgroundColor,
    Widget? button1,
    Widget ?button2,
  }) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        clipBehavior: Clip.antiAlias,
        title: Container(
          child: Column(
            children: <Widget>[
              if(logoPath!=null)
              Center(
                child: LogoAsIcon(
                  color: Theme.of(context).accentColor, iconLocation: logoPath,
                ),
              ),
              const Text(
                'Are you leaving?',
                softWrap: true,
              ),
            ],
          ),
        ),
        content: Container(
          child: const Text(
            'Hope to hear your are back soon ',
            softWrap: true,
          ),
        ),
        actions: <Widget>[
          Center(
            child: RoundedButton(
              color: Colors.red,
              press: () => Navigator.of(context).pop(true),
              text: 'Yes',
              heightRatio: 0.06,
              widthRatio: 0.35,
            ),
          ),
          Center(
            child: RoundedButton(
              color: kPrimaryColor,
              press: () => Navigator.of(context).pop(false),
              text: 'No',
              heightRatio: 0.06,
              widthRatio: 0.35,
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> showCustomDialog(context,
      {String? txt1,
      String? txt2,
      String? actionText1,
      String? actionText2,
      Function? action1,
      Function? action2}) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        clipBehavior: Clip.antiAlias,
        title: Container(
          child: Column(
            children: <Widget>[
              Center(
                child: LogoAsIcon(
                  iconLocation: 'assets/icons/icon350.png',
                  color: Theme.of(context).accentColor,
                ),
              ),
              Text(
                txt1??'',
                softWrap: true,
              ),
            ],
          ),
        ),
        content: Container(
          child: Text(
            txt2??'',
            softWrap: true,
          ),
        ),
        actions: <Widget>[
          Center(
            child: RoundedButton(
              color: Colors.red,
              press: () => action1,
              text: actionText1??'_',
              heightRatio: 0.06,
              widthRatio: 0.35,
            ),
          ),
          Center(
            child:  RoundedButton(
              color: kPrimaryColor,
              press: () => action2,
              text: actionText2??'_',
              heightRatio: 0.06,
              widthRatio: 0.35,
            ),
          ),
        ],
      ),
    );
  }


  Future<dynamic> showVerificationAlertDialog (context, Future<dynamic>Function() onSendVerification){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
          content: Text('Please verify your email before continue',),
            title: Text('your email is not verified',style: TextStyle(color: Colors.white),),
            backgroundColor: darkYellow.withOpacity(0.8).withBlue(50),
            actions: [
              FittedBox(
                child: RoundedButton(
                  text: 'Ok',
                  press: () {
                    Navigator.of(context).pop();
                  },
                  heightRatio: 0.055,
                  widthRatio: 0.3,
                ),
              ),
              FittedBox(
                child: RoundedButton(
                  text: 'Send again',
                  press: () async {
                    await onSendVerification();
                    Navigator.of(context).pop();
                  },
                  heightRatio: 0.055,
                  widthRatio: 0.3,
                ),
              ),
            ],
          );
        });
  }
}
