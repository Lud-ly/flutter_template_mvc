library textSyles;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomTextStyle {
  static TextStyle small({Color? fontColor}) {
    if (fontColor != null) {
      return TextStyle(
        fontSize: kIsWeb ? 15 : 9,
        color: fontColor,
      );
    } else {
      return const TextStyle(
        fontSize: kIsWeb ? 15 : 9,
      );
    }
  }

  static TextStyle medium({Color? fontColor}) {
    if (fontColor != null) {
      return TextStyle(
        fontSize: kIsWeb ? 17 : 15,
        color: fontColor,
      );
    } else {
      return const TextStyle(
        fontSize: kIsWeb ? 17 : 15,
      );
    }
  }

  static TextStyle big({Color? fontColor}) {
    if (fontColor != null) {
      return TextStyle(
        fontSize: kIsWeb ? 22 : 20,
        color: fontColor,
      );
    } else {
      return const TextStyle(
        fontSize: kIsWeb ? 22 : 20,
      );
    }
  }

  static TextStyle giant({Color? fontColor}) {
    if (fontColor != null) {
      return TextStyle(
        fontSize: kIsWeb ? 30 : 25,
        color: fontColor,
      );
    } else {
      return const TextStyle(
        fontSize: kIsWeb ? 30 : 25,
      );
    }
  }

  static TextStyle normalBold({Color? fontColor}) {
    if (fontColor != null) {
      return TextStyle(
        fontSize: kIsWeb ? 15 : 9,
        fontWeight: FontWeight.bold,
        color: fontColor,
      );
    } else {
      return const TextStyle(
        fontSize: kIsWeb ? 15 : 9,
        fontWeight: FontWeight.bold,
      );
    }
  }

  static TextStyle mediumBold({Color? fontColor}) {
    if (fontColor != null) {
      return TextStyle(
        fontSize: kIsWeb ? 17 : 15,
        fontWeight: FontWeight.bold,
        color: fontColor,
      );
    } else {
      return const TextStyle(
        fontSize: kIsWeb ? 17 : 15,
        fontWeight: FontWeight.bold,
      );
    }
  }

  static TextStyle bigBold({Color? fontColor}) {
    if (fontColor != null) {
      return TextStyle(
        fontSize: kIsWeb ? 22 : 20,
        fontWeight: FontWeight.bold,
        color: fontColor,
      );
    } else {
      return const TextStyle(
        fontSize: kIsWeb ? 22 : 20,
        fontWeight: FontWeight.bold,
      );
    }
  }

  static TextStyle smallUnderlined({Color? fontColor}) {
    if (fontColor != null) {
      return TextStyle(
        fontSize: kIsWeb ? 15 : 9,
        decoration: TextDecoration.underline,
        color: fontColor,
      );
    } else {
      return const TextStyle(
        decoration: TextDecoration.underline,
        fontSize: kIsWeb ? 15 : 9,
      );
    }
  }
}
