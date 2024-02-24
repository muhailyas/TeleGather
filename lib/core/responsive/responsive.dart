import 'package:flutter/material.dart';

class Responsive {
  static double height = 0;
  static double width = 0;
  static double text = 0;
  static void init(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    text = MediaQuery.of(context).textScaleFactor;
  }
}
