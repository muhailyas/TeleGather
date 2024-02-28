import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_call_app/core/responsive/responsive.dart';
import 'package:video_call_app/core/theme/theme.dart';
import 'package:video_call_app/features/home/controller/join_controller.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    this.isJoinCode = false,
  });
  final String label;
  final bool isJoinCode;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: Responsive.width * 0.09),
        child: TextFormField(
          controller: controller,
          onChanged: (value) {
            if (isJoinCode) {
              context
                  .read<JoinWithCodeController>()
                  .validateJoinCode(value.trim());
            }
          },
          validator: (value) {
            if (value!.isEmpty) {
              return "$label is required";
            }
            return null;
          },
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          decoration: InputDecoration(
            label: Text(label),
            labelStyle:
                TextStyle(color: Theme.of(context).colorScheme.secondary),
            focusedBorder: textFieldBorderStyle(context),
            border: textFieldBorderStyle(context),
            enabledBorder: textFieldBorderStyle(context),
          ),
        ));
  }
}
