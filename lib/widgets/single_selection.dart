import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:readers_circle/utils/colors.dart';

class SingleChoice extends StatefulWidget {
  final List<dynamic>? options;
  final ValueChanged<String>? onChanged;
  const SingleChoice({
    super.key,
    required this.options,
    this.onChanged,
  });

  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {
  String selectedValue = "";

  @override
  initState() {
    selectedValue = widget.options!.elementAt(0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
          border: Border.all(color: CustomColors.black),
          borderRadius: BorderRadius.circular(5)),
      child: Card(
        elevation: 0.0,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            itemHeight: null,
            menuMaxHeight: 200,
            elevation: 20,
            style: const TextStyle(color: Colors.black, fontSize: 13),
            iconSize: 30.0,
            dropdownColor: CustomColors.broder,
            value: selectedValue, // Bind the selected value here
            items: widget.options!.map((option) {
              return DropdownMenuItem<String>(
                value: option, // Use the actual option as the value
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    option.toString(),
                    style: const TextStyle(fontSize: 15, color: Colors.black),
                  ).tr(),
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedValue = value!;
                widget.onChanged!(selectedValue);
              });
            },
          ),
        ),
      ),
    );
  }
}
