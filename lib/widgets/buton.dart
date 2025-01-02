import 'package:flutter/material.dart';
import 'package:readers_circle/utils/colors.dart';

class CustomActionButton extends StatefulWidget {
  final Function onTap;
  final Widget child;
  const CustomActionButton(
      {super.key, required this.onTap, required this.child});

  @override
  State<CustomActionButton> createState() => _CustomActionButtonState();
}

class _CustomActionButtonState extends State<CustomActionButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.onTap();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.primary,
        minimumSize: const Size.fromHeight(50), // NEW
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: widget.child,
      ),
    );
  }
}
