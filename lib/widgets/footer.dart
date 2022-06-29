import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:whowhats/auth/register.dart';
import 'package:whowhats/widgets/rounded_image.dart';
import '../reusable/lib_images.dart';
import '../reusable/shortcuts.dart';
import '../screen/home.dart';
import '../auth/login.dart';

class Footer extends StatefulWidget {
  final ScrollController? _scrollControlleur;
  const Footer([this._scrollControlleur, Key? key]) : super(key: key);

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  bool _isHidden = false;
  final double _footerHeight = kIsWeb ? 85 : 65;

  @override
  void initState() {
    super.initState();
    widget._scrollControlleur?.addListener(_listen);
  }

  @override
  dispose() {
    widget._scrollControlleur?.removeListener(_listen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget footer = SizedBox(
      height: _footerHeight,
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const <Widget>[
                _BubbleButton(
                  _PageType.home,
                  "assets/images/undraw_handcrafts_house.png",
                  key: const Key("Home"),
                ),
                _BubbleButton(
                  _PageType.login,
                  "assets/images/undraw_handcrafts_briefcase.png",
                  key: const Key("search"),
                ),
                _BubbleButton(
                  _PageType.registration,
                  "assets/images/undraw_handcrafts_search.png",
                  key: const Key("file"),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    if (widget._scrollControlleur != null) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 700),
        child: Wrap(
          children: [footer],
        ),
        height: _isHidden ? 0 : _footerHeight,
      );
    }
    return footer;
  }

  _listen() {
    final direction = widget._scrollControlleur?.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      if (_isHidden) {
        _isHidden = false;
      }
      setState(() {});
    } else if (direction == ScrollDirection.reverse) {
      if (!_isHidden) {
        _isHidden = true;
      }
      setState(() {});
    }
  }
}

class _BubbleButton extends StatelessWidget {
  final _PageType _page;
  final String _imagePath;

  const _BubbleButton(this._page, this._imagePath, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: CodeShortcuts.getAppWidth(context) * 0.2,
      child: Column(
        children: [
          IconButton(
            onPressed: () => _goTo(_page),
            icon: RoundedImage(_imagePath, 50, 50, ""),
            iconSize: 60,
          ),
        ],
      ),
    );
  }

  _goTo(_PageType page) {
    switch (page) {
      case _PageType.login:
        Get.to(() => Login());
        break;
      case _PageType.registration:
        Get.to(() => const RegisterPage());
        break;
      case _PageType.home:
        Get.to(() => Home());
        break;
    }
  }
}

enum _PageType { login, registration, home }
