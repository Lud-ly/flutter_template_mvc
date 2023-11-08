import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LibColors {
  static Color cfirst = Color.fromRGBO(69, 25, 82, 1);
  static Color csecond = Color.fromRGBO(102, 37, 73, 1);
  static Color cthird = Color.fromRGBO(174, 68, 90, 1);
  static Color cfourth = Color.fromRGBO(243, 159, 90, 1);

  static Color LIGHT_GREY = const Color.fromRGBO(237, 237, 237, 1);
  static Color GREY = const Color.fromRGBO(247, 247, 247, 1);
  static Color DARK_GREY = const Color.fromRGBO(59, 59, 59, 1);

  static Color getColorPrimary(BuildContext context) {
    return Theme.of(context).colorScheme.primary;
  }

  static Color getColorSecondary(BuildContext context) {
    return Theme.of(context).colorScheme.secondary;
  }

  static Color getColorTertiary(BuildContext context) {
    return Theme.of(context).colorScheme.tertiary;
  }
}
