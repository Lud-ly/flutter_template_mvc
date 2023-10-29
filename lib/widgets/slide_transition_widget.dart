import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../reusable/image_path.dart';

class SlideTransitionWidget extends StatefulWidget {
  const SlideTransitionWidget({Key? key}) : super(key: key);

  @override
  State<SlideTransitionWidget> createState() => _SlideTransitionWidgetState();
}

class _SlideTransitionWidgetState extends State<SlideTransitionWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(5.5, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.slowMiddle,
  ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SlideTransition(
            position: _offsetAnimation,
            child: Padding(
                padding: EdgeInsets.all(8.0),
                child: ImagePath("assets/images/LaLiga.png")),
          ),
          SlideTransition(
            position: _offsetAnimation,
            child: Padding(
                padding: EdgeInsets.all(8.0),
                child: ImagePath("assets/images/Premier_League.png")),
          ),
          SlideTransition(
            position: _offsetAnimation,
            child: Padding(
                padding: EdgeInsets.all(8.0),
                child: ImagePath("assets/images/SerieALogo.png")),
          ),
          SlideTransition(
            position: _offsetAnimation,
            child: Padding(
                padding: EdgeInsets.all(8.0),
                child: ImagePath("assets/images/Ligue_1_Conforama.png")),
          ),
          SlideTransition(
            position: _offsetAnimation,
            child: Padding(
                padding: EdgeInsets.all(8.0),
                child: ImagePath("assets/images/Logo_Bundesliga.png")),
          ),
        ],
      ),
    );
  }
}
