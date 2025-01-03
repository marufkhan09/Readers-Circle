import 'package:flutter/material.dart';
import 'package:readers_circle/utils/colors.dart';

class NumberField extends StatefulWidget {
  const NumberField({super.key});

  @override
  State<NumberField> createState() => _NumberFieldState();
}

class _NumberFieldState extends State<NumberField> {
  final TextEditingController _numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8, bottom: 8.0),
      width: 100,
      child: TextFormField(
        controller: _numberController,
        keyboardType: TextInputType.phone,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          fillColor: CustomColors.white,
          filled: true,
          contentPadding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
          hintStyle: TextStyle(fontSize: 16.0, color: CustomColors.broder),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(color: CustomColors.broder, width: 0.5),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Can't be empty";
          }
          return null;
        },
      ),
    );
  }
}
