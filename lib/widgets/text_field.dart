import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:readers_circle/utils/colors.dart';

class TextInput extends StatefulWidget {
  final Function(String?) onDone;
  final TextInputAction textInputAction;
  final TextInputType? keyboardType;
  final String? hint;

  const TextInput(
      {super.key,
      required this.onDone,
      required this.textInputAction,
      required this.keyboardType,
      this.hint});

  @override
  State<TextInput> createState() => _TextState();
}

class _TextState extends State<TextInput> {
  final TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _textController,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      onFieldSubmitted: (value) {
        if (value.isNotEmpty) {
          widget.onDone(value);
        }
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          widget.onDone(value);
        }
      },
      decoration: InputDecoration(
        fillColor: CustomColors.white,
        filled: true,
        hintText: widget.hint ?? "",
        contentPadding: const EdgeInsets.fromLTRB(15.0, 5.0, 5.0, 5.0),
        hintStyle: TextStyle(fontSize: 16.0, color: CustomColors.broder),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: CustomColors.primary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: CustomColors.broder,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Can't be empty";
        } else if (widget.hint == tr("emailHint") &&
            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value)) {
          return "Invalid email address!";
        }
        return null;
      },
    );
  }
}
