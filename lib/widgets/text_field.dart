import 'package:flutter/material.dart';
import 'package:readers_circle/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';

class TextInput extends StatefulWidget {
  final Function(String?) onDone;
  final TextInputAction textInputAction;
  final TextInputType? keyboardType;
  final String? hint;
  final bool validateOnInteraction; // Flag to control validation
  final TextCapitalization textCapitalization; // To capitalize text if needed

  const TextInput({
    super.key,
    required this.onDone,
    required this.textInputAction,
    required this.keyboardType,
    this.hint,
    this.validateOnInteraction = true, // Default to true for validation
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  State<TextInput> createState() => _TextState();
}

class _TextState extends State<TextInput> {
  final TextEditingController _textController = TextEditingController();
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _textController,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      textCapitalization: widget.textCapitalization,
      onFieldSubmitted: (value) {
        if (value.isNotEmpty && widget.validateOnInteraction) {
          widget.onDone(
              value); // This will now handle submission when the field is submitted
        }
      },
      onChanged: (value) {
        if (widget.validateOnInteraction) {
          setState(() {
            _errorMessage =
                _validate(value); // Handle validation when the value changes
          });
        }
        if (value.isNotEmpty) {
          widget.onDone(value); // Return the value immediately after it changes
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
          borderSide: const BorderSide(
            color: CustomColors.primary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: CustomColors.broder,
          ),
        ),
        errorText: _errorMessage,
      ),
    );
  }

  // Function to validate the input based on the type of text field
  String? _validate(String value) {
    if (value.isEmpty) {
      return "Can't be empty";
    } else if (widget.hint == tr("emailHint") &&
        !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
            .hasMatch(value)) {
      return "Invalid email address!";
    } else if (widget.hint == tr("nameHint") && value.length < 3) {
      return "Name must be at least 3 characters";
    } else if (widget.hint == tr("phoneHint") &&
        !RegExp(r'^(?:\+88|88)?01[3-9]\d{8}$').hasMatch(value)) {
      return "Invalid Bangladeshi phone number!";
    } else if (widget.hint == tr("numberHint") &&
        !RegExp(r'^[0-9]+$').hasMatch(value)) {
      return "Only numbers are allowed!";
    }
    return null;
  }
}
