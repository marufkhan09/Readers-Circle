import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showMessageToast({required String message, BuildContext? context}) {
  Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.SNACKBAR,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      fontSize: 16.0);
}
