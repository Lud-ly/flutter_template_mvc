import 'package:flutter/cupertino.dart';

class RoundedImage extends StatelessWidget {
  final String _path;
  final double _height;
  final double _width;
  const RoundedImage(this._path, this._height, this._width, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      height: _height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(image: AssetImage(_path), fit: BoxFit.fill),
      ),
    );
  }
}
