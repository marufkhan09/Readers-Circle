import 'package:flutter/material.dart';

DropdownMenuItem<dynamic> dropDownItems({required value, text}) {
  return DropdownMenuItem<dynamic>(
    value: value,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 15),
      ),
    ),
  );
}
