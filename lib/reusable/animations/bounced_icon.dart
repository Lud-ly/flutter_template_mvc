import 'dart:math';
import 'package:flutter/material.dart';

class BouncingIcon extends StatefulWidget {
  final String textChosen;
  final IconData iconChosen;
  final double beginPosition;
  final double endPosition;
  final int duration;
  final double fSizeChosen;
  final double SizeIconChosen;

  const BouncingIcon({
    required this.textChosen,
    required this.fSizeChosen,
    required this.iconChosen,
    required this.SizeIconChosen,
    required this.beginPosition,
    required this.endPosition,
    required this.duration,
  });

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

    _rotationAnimation = Tween<double>(begin: 0, end: 360).animate(
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
    final randomRotation = random.nextDouble() * 360;
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
        Text(
          widget.textChosen,
          style: TextStyle(
            fontFamily: 'PermanentMarker',
            fontSize: widget.fSizeChosen,
            color: Colors.black,
          ),
        ),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _animation.value),
              child: Transform.rotate(
                angle: _rotationAnimation.value * (pi / 180),
                child: Icon(
                  widget.iconChosen,
                  color: Colors.black,
                  size: widget.SizeIconChosen,
                ),
              ),
            );
          },
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
