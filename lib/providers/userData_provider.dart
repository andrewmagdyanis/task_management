import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_management/models/user_model.dart';

class UserDataProvider extends ChangeNotifier {
  UserModel _userModel = UserModel(
    password: '',
    email: '',
    userId: '',
    creationTime: Timestamp.now(),
    userName: '',
    profilePictureUrl: '',
    About: '',
    Phone: '',
    isAdmin: false,
  );
  bool loading = true;

 UserModel get userData {
    return _userModel;
  }

  get loadingState {
    return loading;
  }

  Future<void> fetchAndSetUserData() async {
    loading = true;
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      print(userDoc.data());
      _userModel = UserModel.fromMap(
          userDoc.data() as Map<String,dynamic>);
      // print(_userData);
      notifyListeners();
    } catch (e) {
      print('error is:' + e.toString());
      throw e;
    }
    loading = false;
  }
}
