import 'dart:math';
import 'package:flutter/material.dart';

class BouncingIcon extends StatefulWidget {
  final String text;
  final IconData shape;
  final double beginPosition;
  final double endPosition;
  final int duration;
  final double fSize;
  final double SizeIcon;
  final Color? ColorIcon;

  const BouncingIcon(
      {required this.text,
      required this.fSize,
      required this.shape,
      required this.SizeIcon,
      required this.beginPosition,
      required this.endPosition,
      required this.duration,
      this.ColorIcon});

  @override
  _BouncingIconState createState() => _BouncingIconState();
}

class _BouncingIconState extends State<BouncingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: widget.duration),
      vsync: this,
    );

    _animation =
        Tween<double>(begin: widget.beginPosition, end: widget.endPosition)
            .animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    )..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controller.reverse();
              _updateRotation(); // Génère une nouvelle rotation aléatoire
            } else if (status == AnimationStatus.dismissed) {
              _controller.forward();
            }
          });

    _rotationAnimation = Tween<double>(begin: 0, end: 720).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    _updateRotation(); // Génère une rotation aléatoire initiale
    _controller.forward();
  }

  void _updateRotation() {
    // Génère un angle aléatoire entre 0 et 360 degrés
    final random = Random();
    final randomRotation = random.nextDouble() * 1080;
    _rotationAnimation = Tween<double>(begin: 0, end: randomRotation).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // AnimatedBuilder(
            //   animation: _animation,
            //   builder: (context, child) {
            //     return Transform.rotate(
            //       angle: _rotationAnimation.value * (pi / 180),
            //       child: Icon(
            //         widget.shape,
            //         color:
            //             widget.ColorIcon ?? const Color.fromARGB(109, 0, 0, 0),
            //         size: widget.SizeIcon,
            //       ),
            //     );
            //   },
            // ),
            Text(
              widget.text,
              style: TextStyle(
                fontFamily: 'PermanentMarker',
                fontSize: widget.fSize,
                color: Colors.black,
              ),
            ),
            // Animated Icon
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
