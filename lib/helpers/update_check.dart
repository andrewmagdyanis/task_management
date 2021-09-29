// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:in_app_update/in_app_update.dart';
// import 'package:social_app/widgets/dialogs.dart';
// import 'showError.dart';
//
// Future<void> checkForUpdate(BuildContext context,scaffoldKey) async {
//   InAppUpdate.checkForUpdate().then((AppUpdateInfo info) {
//     if (info.updateAvailable) {
//       print('update available');
//       Dialogs().showCustomDialog(context,
//           txt1: 'It is recommended to update to the latest '
//               'version',
//           txt2: 'please update it now',
//           actionText1: 'update',
//           actionText2: 'not now', action1: () {
//             InAppUpdate.performImmediateUpdate().catchError((e) => showError(e,scaffoldKey));
//           }, action2: () {
//             Navigator.of(context).pop(false);
//           });
//     }
//   }).catchError((e) => showError(e,scaffoldKey));
// }
