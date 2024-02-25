import 'package:flutter/material.dart';

import '../responsive/responsive.dart';

final textFieldBorderStyle = OutlineInputBorder(
  borderSide: const BorderSide(color: Colors.teal),
  borderRadius: BorderRadius.circular(25),
);

final elevatedButtonStyle = ButtonStyle(
    shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
    fixedSize: MaterialStatePropertyAll(
        Size(Responsive.width * 0.8, Responsive.height * 0.065)),
    backgroundColor: const MaterialStatePropertyAll(Colors.white));

final buttonStyle = ButtonStyle(
    backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
    shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
    side: const MaterialStatePropertyAll(BorderSide(color: Colors.teal)));
