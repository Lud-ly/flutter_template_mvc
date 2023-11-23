import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ImagePath extends StatelessWidget {
  const ImagePath(this._imagePath, {Key? key}) : super(key: key);
  final String _imagePath;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      _imagePath,
      scale: kIsWeb ? 2 : 3,
    );
  }
}
