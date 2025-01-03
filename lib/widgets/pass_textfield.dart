import 'package:flutter/material.dart';
import 'package:readers_circle/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';

class PasswordInput extends StatefulWidget {
  final Function(String?) onDone;
  final TextInputAction textInputAction;
  final String? hint;
  final bool validateOnInteraction; // Flag to control validation
  final bool obscureText; // To toggle visibility of the password
  final bool showPasswordToggle; // Flag to show/hide password toggle button

  const PasswordInput({
    super.key,
    required this.onDone,
    required this.textInputAction,
    this.hint,
    this.validateOnInteraction = true, // Default to true for validation
    this.obscureText = true, // Default to obscure the password
    this.showPasswordToggle =
        true, // Allow the user to toggle password visibility
  });

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  final TextEditingController _textController = TextEditingController();
  bool _isPasswordVisible = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _textController,
      textInputAction: widget.textInputAction,
      obscureText: _isPasswordVisible ? false : widget.obscureText,
      onFieldSubmitted: (value) {
        if (value.isNotEmpty && widget.validateOnInteraction) {
          widget.onDone(value);
        }
      },
      onChanged: (value) {
        if (widget.validateOnInteraction) {
          setState(() {
            _errorMessage = _validate(value);
          });
        }
      },
      decoration: InputDecoration(
        fillColor: CustomColors.white,
        filled: true,
        hintText: widget.hint ?? tr("passwordHint"),
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
        suffixIcon: widget.showPasswordToggle
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: CustomColors.primary,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : null,
      ),
    );
  }

  String? _validate(String value) {
    if (value.isEmpty) {
      return "Password can't be empty";
    } else if (value.length < 8) {
      return "Password must be at least 8 characters long";
    } else if (!RegExp(
            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$')
        .hasMatch(value)) {
      return "Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character";
    }
    return null;
  }
}
