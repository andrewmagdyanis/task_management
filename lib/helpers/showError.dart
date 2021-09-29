import 'package:flutter/material.dart';

void showError(dynamic exception,scaffoldKey) {
  print(exception.toString());
  scaffoldKey.currentState
      .showSnackBar(SnackBar(content: Text(exception.toString())));
}