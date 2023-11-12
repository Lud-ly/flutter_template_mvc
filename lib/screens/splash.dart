import 'package:flutter/material.dart';

class AnimatedM extends StatefulWidget {
  @override
  _AnimatedMState createState() => _AnimatedMState();
}

class _AnimatedMState extends State<AnimatedM>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4), // Durée de l'animation
    );

    _animation = Tween(begin: Offset(0.0, 0.0), end: Offset(1.0, 0.0)).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticInOut, // Courbe d'animation personnalisée
      ),
    );

    _controller.repeat(reverse: true); // Répéter l'animation en sens inverse

    // Décommentez cette partie pour arrêter l'animation après un certain délai
    Future.delayed(Duration(seconds: 10), () {
      _controller.stop();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fond blanc
      body: Center(
        child: SlideTransition(
          position: _animation,
          child: Text(
            'M',
            style: TextStyle(
              fontSize: 48, // Taille de la police
              color: Colors.black, // Couleur du "M"
              fontWeight: FontWeight.bold, // Police en gras
            ),
          ),
        ),
      ),
    );
  }
}
