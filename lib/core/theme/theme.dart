import 'package:flutter/material.dart';

import '../responsive/responsive.dart';

OutlineInputBorder textFieldBorderStyle(BuildContext context) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
    borderRadius: BorderRadius.circular(25),
  );
}

ButtonStyle elevatedButtonStyle(BuildContext context) {
  return ButtonStyle(
      shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      fixedSize: MaterialStatePropertyAll(
          Size(Responsive.width * 0.8, Responsive.height * 0.065)),
      backgroundColor:
          MaterialStatePropertyAll(Theme.of(context).colorScheme.primary));
}

buttonStyle(context) {
  return ButtonStyle(
      backgroundColor:
          MaterialStatePropertyAll(Theme.of(context).colorScheme.background),
      shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      side: const MaterialStatePropertyAll(BorderSide(color: Colors.teal)));
}
