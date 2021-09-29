import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:task_management/helpers/internet_check.dart';
import 'package:task_management/helpers/sizes_helpers.dart';
import 'package:task_management/models/user_model.dart';
import 'package:task_management/widgets/auth/auth_app_logo.dart';
import 'package:task_management/widgets/auth/auth_app_name.dart';
import 'package:task_management/widgets/auth/auth_app_tabBar.dart';
import 'package:task_management/widgets/auth/auth_app_tabBar_view.dart';
import 'package:task_management/widgets/background.dart';
import 'package:task_management/widgets/rounded_button.dart';

class AuthScreenDoubleForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthScreenBody();
  }
}

class AuthScreenBody extends StatefulWidget {
  @override
  _AuthScreenBodyState createState() => _AuthScreenBodyState();
}

class _AuthScreenBodyState extends State<AuthScreenBody> with SingleTickerProviderStateMixin {
  // AppUpdateInfo _updateInfo;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  late TabController tabController;
  final auth = FirebaseAuth.instance;

  Future<bool> authenticate({
    String? userName,
    File? image,
    required String email,
    required String password,
    required bool isLogin,
    required BuildContext context,
    String? phone,
  }) async {
    bool internetIsConnected = await internetChecks(context);
    if (internetIsConnected) {
      try {
        UserCredential userCredential;
        if (isLogin) {
          print('login ...');
          print(email);
          print(password);
          userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
          print(email +
              ' is: ' +
              ((userCredential.user!.emailVerified) ? 'verified' : 'not Verified'));
          return true;
        } else {
          print('signup ...');
          userCredential = await auth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );

          await userCredential.user!.sendEmailVerification();

          String imageUrl = '';
          if (image == null) {
            imageUrl =
                'https://firebasestorage.googleapis.com/v0/b/youth-meeting-budget.appspot.com/o/icon350.png?alt=media&token=b48f1d0a-be1d-4fd8-a527-a82671eb174d';
          } else {
            final storage = FirebaseStorage.instance;
            final ref = storage
                .ref('Users Images')
                .child(userCredential.user!.uid)
                .child(userName??'' + '.jpg');

            await ref.putFile(image);

            imageUrl = await ref.getDownloadURL();
          }
          final userModel = UserModel(
            email: email,
            password: password,
            userName: userName??'',
            userId: userCredential.user!.uid,
            profilePictureUrl: imageUrl,
            creationTime: Timestamp.now(),
            isAdmin: false,
            About: '',
            Phone: phone??'',
          );
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(userCredential.user!.uid)
              .set(userModel.toMap());

          final currentUser = FirebaseAuth.instance.currentUser;
          await currentUser!.updateProfile(displayName: userName, photoURL: imageUrl);
          return true;
        }
      } on PlatformException catch (e) {
        print(e.message);
        var msg = 'Error Occured, Please check your credentials';
        if (e.message != null) {
          msg = e.message!;
        }
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(msg),
          backgroundColor: Theme.of(context).errorColor,
          duration: Duration(seconds: 3),
        ));
        return false;
      } catch (e) {
        print('error in auth: ' + e.toString());
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
          backgroundColor: Theme.of(context).errorColor,
          duration: Duration(seconds: 3),
        ));
        return false;
      }
      // return true;
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Network Error'),
              content: Text('Please check your network adaptor'),
              actions: [
                RoundedButton(
                  text: 'Ok',
                  heightRatio: 0.05,
                  press: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
      return false;
    }
  }

  void _showError(dynamic exception) {
    print(exception.toString());
    _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(exception.toString())));
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final h = displayHeight(context);
    final w = displayWidth(context);
    return Background(
      key: _scaffoldKey,
      assetImageLocation: "assets/images/background7.jpg",
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: h / 30, bottom: h / 30),
          child: SingleChildScrollView(
            physics: ScrollPhysics(parent: BouncingScrollPhysics()),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AuthAppLogo(w: w, h: h),
                AuthAppName(w: w, h: h),
                AuthTabBar(tabController: tabController),
                AuthTabBarView(
                    tabController: tabController, w: w, h: h, authenticate: authenticate),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
