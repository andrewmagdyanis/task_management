import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_management/models/user_model.dart';


class UsersListProvider extends ChangeNotifier {
  Map<String, UserModel> _users = {};
  bool loading = true;

  Map<String, UserModel> get usersMap {
    return {..._users};
  }

  get loadingState {
    return loading;
  }

  Future<void> fetchAndSetUsersList() async {
    loading = true;
    try {
      QuerySnapshot usersDocListSnap =
          await FirebaseFirestore.instance.collection('Users').get();
      final List<DocumentSnapshot> usersDocList = usersDocListSnap.docs;
      _users.addEntries(usersDocList
          .map((doc) => MapEntry(doc.id, UserModel.fromMap(doc.data() as Map<String, dynamic>))));
      notifyListeners();
    } catch (e) {
      print('error is:' + e.toString());
      throw e;
    }
    loading = false;
  }
}
