import 'package:flutter/material.dart';
import 'package:readers_circle/utils/colors.dart';
import 'package:readers_circle/utils/keys.dart';

class CustomSnackBar {
  String text;
  bool isError;
  CustomSnackBar({required this.text, required this.isError});
  show() {
    GlobalVariableKeys.scaffoldMessengerState.currentState!
        .showSnackBar(SnackBar(
      content: Text(
        text,
        style: TextStyle(color: CustomColors.white, fontSize: 20),
      ),
      backgroundColor: isError ? Colors.red : CustomColors.primary,
      duration: const Duration(seconds: 2),
    ));
  }
}
