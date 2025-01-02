import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  final String fieldName;
  final bool mandatory;
  const CustomRichText(
      {super.key, required this.fieldName, required this.mandatory});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black, fontSize: 16.0),
        text: fieldName,
        children: [
          TextSpan(
              text: mandatory ? '*' : "",
              style: const TextStyle(color: Colors.red))
        ],
      ),
    );
  }
}
