// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class CheckBoxWidget extends StatefulWidget {
//   final int? qIndex;
//   final List<dynamic>? options;
//   const CheckBoxWidget({super.key, required this.qIndex, this.options});
//
//   @override
//   State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
// }
//
// class _CheckBoxWidgetState extends State<CheckBoxWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<OptionsProvider>(builder: (context, provider, child) {
//       provider.optionsResponse = widget.options!;
//       return ListView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: provider.optionsResponse.length,
//         itemBuilder: (context, index) {
//           return CheckboxListTile(
//             controlAffinity: ListTileControlAffinity.leading,
//             contentPadding: EdgeInsets.zero,
//             dense: true,
//             title: Text(
//               provider.optionsResponse.elementAt(index).title!,
//               style: const TextStyle(
//                 fontSize: 14.0,
//                 color: Colors.black,
//               ),
//             ),
//             value: provider.optionsResponse.elementAt(index).isSelected,
//             onChanged: (value) {
//               provider.selectCheckBoxItems(
//                   qIndex: widget.qIndex, index: index, value: value);
//             },
//           );
//         },
//       );
//     });
//   }
// }
