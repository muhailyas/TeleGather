import 'package:flutter/material.dart';
import 'package:video_call_app/core/responsive/responsive.dart';
import 'package:video_call_app/core/theme/theme.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget(
      {super.key, required this.controller, required this.label});
  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: Responsive.width * 0.09),
        child: TextFormField(
          controller: controller,
          validator: (value) {
            if (value!.isEmpty) {
              return "$label is required";
            }
            return null;
          },
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            label: Text(label),
            labelStyle: const TextStyle(color: Colors.white),
            focusedBorder: textFieldBorderStyle,
            border: textFieldBorderStyle,
            enabledBorder: textFieldBorderStyle,
          ),
        ));
  }
}
