import 'package:flutter/material.dart';
import 'dart:async';

import '../reusable/lib_images.dart';
import '../reusable/rounded_buttons.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  double _top = 0; // Position verticale initiale
  double _left = 0; // Position horizontale initiale
  double _directionX = 1; // Direction horizontale (1 ou -1)
  double _directionY = 1; // Direction verticale (1 ou -1)
  bool _stopMoving = false; // Variable pour contrôler l'arrêt du mouvement
  late Timer _timer; // Timer initialisé ultérieurement
  late double _backgroundOpacity;

  late BoxDecoration _backgroundDecoration;

  @override
  void initState() {
    super.initState();
    _backgroundOpacity = 0.0;
    _backgroundDecoration = _getDefaultBackgroundDecoration();

    startMoving();
  }

  BoxDecoration _getDefaultBackgroundDecoration() {
    return BoxDecoration(
      color: Colors.white,
      image: DecorationImage(
        image: BACKGROUND, // Ajoutez votre image ici
        fit: BoxFit.fill,
      ),
    );
  }

  void startMoving() async {
    const moveInterval =
        Duration(milliseconds: 16); // Intervalle de déplacement
    _timer = Timer.periodic(moveInterval, (timer) {
      setState(() {
        if (!_stopMoving) {
          _top += 10 * _directionY;
          _left += 10 * _directionX;

          if (_top <= 0 || _top >= (MediaQuery.of(context).size.height - 50)) {
            _directionY *= -1;
          }
          if (_left <= 0 || _left >= (MediaQuery.of(context).size.width - 50)) {
            _directionX *= -1;
          }
        }
      });
    });

    // Arrêter le mouvement après 3 secondes et recentrer le bouton
    Future.delayed(Duration(seconds: 2), () {
      _backgroundOpacity = 1.0;
      setState(() {
        _stopMoving = true; // Met fin au mouvement
        _top = (MediaQuery.of(context).size.height - 120) / 2;
        _left = (MediaQuery.of(context).size.width - 120) / 2;
        _timer.cancel(); // Arrête le timer de mouvement
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedOpacity(
            duration: Duration(seconds: 2),
            opacity: _backgroundOpacity,
            child: Container(
              decoration: _backgroundDecoration,
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            top: _top,
            left: _left,
            child: GoButton3D(),
          ),
        ],
      ),
    );
  }
}
