import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:task_management/widgets/dialogs.dart';

Future<bool> internetChecks(BuildContext context) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    return true;
  } else {
    Dialogs().showErrorDialog(context, errorStatement: 'please, check the internet connectivity');
    return false;
  }
}
