import 'package:flutter/material.dart';
import 'package:readers_circle/utils/colors.dart';

class SingleChoice extends StatefulWidget {
  final List<dynamic>? options;
  const SingleChoice({
    super.key,
    required this.options,
  });

  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {
  String selectedValue = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
          border: Border.all(color: CustomColors.broder),
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
            items: List.generate(
                widget.options!.length,
                (index) => DropdownMenuItem<String>(
                      value: selectedValue.isNotEmpty
                          ? selectedValue
                          : widget.options!.elementAt(0).title,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.options!.elementAt(index).title!,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    )),
            onChanged: (value) {
              setState(
                () {
                  selectedValue = value!;
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
