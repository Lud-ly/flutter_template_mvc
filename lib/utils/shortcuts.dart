import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;

class CodeShortcuts {
  static toast(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  static Future<Uint8List> getBytesFromAsset(
      {required String path, required int width}) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  static ImageProvider<Object> treatImage(String path, {String? defaultPath}) {
    if (path.startsWith("assets/images/")) {
      return AssetImage(path);
    } else {
      return Image.network(
        path,
        errorBuilder: (_, __, ___) {
          return Image.asset(defaultPath ?? "assets/images/error_pick.png");
        },
      ).image;
    }
  }

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
