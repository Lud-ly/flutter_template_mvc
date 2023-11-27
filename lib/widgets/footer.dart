import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:whowhats/screens/welcome.dart';
import 'package:whowhats/reusable/libs/tools_lib.dart';

import '../api/firebase_services.dart';
import '../screens/home.dart';
import '../screens/account.dart';

class Footer extends StatefulWidget {
  final ScrollController _scrollController;
  const Footer(this._scrollController, [Key? key]) : super(key: key);

  @override
  State<Footer> createState() => FooterState();
}

class FooterState extends State<Footer> {
  bool _isHidden = false;

  @override
  void initState() {
    super.initState();

    widget._scrollController.addListener(_listen);
  }

  @override
  void dispose() {
    widget._scrollController.removeListener(_listen);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double _footerHeight = kIsWeb ? 80 : SCREEN_HEIGHT(context) * 0.065;

    Widget footer = SizedBox(
      height: _footerHeight,
      width: SCREEN_WIDTH(context),
      child: Container(
        color: Colors.white,
        child: CustomPaint(
          painter: WavePainter(),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _BubbleButton(
                        _PageType.home,
                        Icon(Icons.home),
                        "Home",
                        key: const Key("goToHomeBtn"),
                      ),
                      _BubbleButton(
                        _PageType.alarm,
                        Icon(Icons.alarm),
                        "Alarme",
                        key: const Key("goToAlarmeBtn"),
                      ),
                      _BubbleButton(
                        _PageType.account,
                        Icon(Icons.account_box),
                        "Account",
                        key: const Key("goToAccountBtn"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (widget._scrollController != null) {
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
    final direction = widget._scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      if (_isHidden) {
        setState(() {
          _isHidden = false;
        });
      }
    } else if (direction == ScrollDirection.reverse) {
      if (!_isHidden) {
        setState(() {
          _isHidden = true;
        });
      }
    }
  }
}

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black // Changer la couleur ici
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0; // Changer l'épaisseur ici

    final path = Path();
    path.moveTo(0, 0); // Commence au coin supérieur gauche

    // Premier point de contrôle
    path.quadraticBezierTo(size.width / 4, -20.0, size.width / 2, 0);

    // Deuxième point de contrôle
    path.quadraticBezierTo(3 * size.width / 4, 20.0, size.width, 0);

    path.lineTo(
        size.width, size.height); // Ligne verticale jusqu'au bas du footer
    path.lineTo(
        0, size.height); // Ligne horizontale jusqu'au coin inférieur gauche

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 4, size.height - 30.0, size.width / 2, size.height);
    path.quadraticBezierTo(
        3 * size.width / 4, size.height - 30.0, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class _BubbleButton extends StatefulWidget {
  final _PageType _page;
  final String _text;
  final Icon _icon;

  _BubbleButton(this._page, this._icon, this._text, {Key? key})
      : super(key: key);

  @override
  _BubbleButtonState createState() => _BubbleButtonState();
}

class _BubbleButtonState extends State<_BubbleButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.2,
      child: Column(
        children: [
          Flexible(
            child: IconButton(
              onPressed: () {
                _goTo(widget._page);
              },
              color: Colors.black,
              icon: widget._icon,
              iconSize: 35,
            ),
          ),
        ],
      ),
    );
  }

  _goTo(_PageType page) {
    switch (page) {
      case _PageType.home:
        Get.to(() => HomePage());
        break;
      case _PageType.alarm:
        Get.to(() => AccountPage());
        break;
      case _PageType.account:
        Get.to(() => AccountPage());
        break;
      case _PageType.logout:
        FirebaseServices.disconnect();
        Get.to(() => Welcome());
        break;
    }
  }
}

enum _PageType { home, alarm, account, logout }
