import 'package:flutter/material.dart';

class CodeShortcuts {
  static MaterialStateProperty<Color> getColor(Color color) {
    return MaterialStateProperty.all(color);
  }

  static MaterialStateProperty<Image> getImage(Image image) {
    return MaterialStateProperty.all(image);
  }

  static double getAppHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getAppWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static toast(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  static getLightGrey() {
    return const Color.fromRGBO(237, 237, 237, 1);
  }

  static getGrey() {
    return const Color.fromRGBO(247, 247, 247, 1);
  }

  static getWhite() {
    return Colors.white;
  }

  static getBlack() {
    return Colors.black54;
  }

  static sizeIconChat() {
    return 25.0;
  }

  static getColorRowButton() {
    return const Color.fromRGBO(255, 255, 255, 1);
  }
}
