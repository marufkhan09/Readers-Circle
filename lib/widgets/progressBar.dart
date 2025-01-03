import 'package:flutter/material.dart';
import 'package:readers_circle/utils/keys.dart';

class CustomProgressDialog {
  static BuildContext? _dialogContext; // Store dialog context

  static Future<void> show(
      {String message = "Loading...", bool isDismissible = false}) {
    // Store the context when showing the dialog
    final context = GlobalVariableKeys.navigatorState.currentContext!;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        _dialogContext = context;
        return PopScope(
          canPop: isDismissible,
          child: AlertDialog(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(10), // Set the border radius here
            ),
            contentPadding: EdgeInsets.zero,
            content: SizedBox(
              height: 100,
              width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CircularProgressIndicator(),
                  Text(
                    message,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void hide() {
    if (_dialogContext != null) {
      Navigator.of(_dialogContext!)
          .pop(); // Use stored context to pop the dialog
      _dialogContext = null; // Clear the stored context
    }
  }
}
