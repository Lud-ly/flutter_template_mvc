import 'package:flutter/material.dart';

class BouncingIcon extends StatefulWidget {
  final String textChoisi;
  final IconData iconChoisi;

  const BouncingIcon({
    required this.textChoisi,
    required this.iconChoisi,
  });

  @override
  _BouncingIconState createState() => _BouncingIconState();
}

class _BouncingIconState extends State<BouncingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _animation = Tween<double>(begin: -5, end: -1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.textChoisi,
          style: TextStyle(
            fontFamily: 'PermanentMarker',
            fontSize: 10,
            color: Colors.black,
          ),
        ),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _animation.value),
              child: Icon(
                widget.iconChoisi,
                color: Colors.black,
                size: 18.0,
              ),
            );
          },
        ),
      ],
    );
  }
}
