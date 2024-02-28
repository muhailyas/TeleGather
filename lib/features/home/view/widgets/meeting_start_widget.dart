import 'package:flutter/material.dart';
import 'package:video_call_app/core/responsive/responsive.dart';

class MeetingStartWidget extends StatelessWidget {
  const MeetingStartWidget({
    super.key,
    this.border,
    required this.text,
    this.backgroundColor = Colors.teal,
    this.height = 40,
    this.textColor = Colors.white,
  });
  final double height;
  final Color backgroundColor;
  final String text;
  final Color textColor;
  final bool? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: Responsive.width / 2.2,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: border != null
            ? Border.all(color: Theme.of(context).colorScheme.primary)
            : null,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
          child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: Responsive.text * 15,
        ),
      )),
    );
  }
}
