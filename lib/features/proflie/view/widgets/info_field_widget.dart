import 'package:flutter/material.dart';
import '../../../../core/responsive/responsive.dart';

class InfoFieldWidget extends StatelessWidget {
  const InfoFieldWidget({super.key, required this.text, this.trailing});
  final String text;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.width * 0.62,
      height: Responsive.height * 0.048,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.primary),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Responsive.height * 0.012,
            horizontal: Responsive.width * 0.04),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: Responsive.width / 2.1,
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            trailing ?? const SizedBox()
          ],
        ),
      ),
    );
  }
}
