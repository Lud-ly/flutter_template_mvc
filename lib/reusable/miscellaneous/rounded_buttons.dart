import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whowhats/auth/login.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {required this.colour, required this.title, required this.onPressed});
  final Color colour;
  final String title;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed(),
          //Go to login screen.
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class GoButton extends StatefulWidget {
  @override
  _GoButtonState createState() => _GoButtonState();
}

class _GoButtonState extends State<GoButton>
    with SingleTickerProviderStateMixin {
  bool isTapped = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startRotationAnimation() {
    _controller.forward(from: 0.0);
    setState(() {
      isTapped = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: isTapped
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 9, 205, 16),
                    Color.fromARGB(255, 10, 255, 18)
                  ],
                )
              : LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(193, 255, 255, 255),
                    Color.fromARGB(208, 255, 255, 255),
                  ],
                ),
          boxShadow: isTapped
              ? [
                  BoxShadow(
                    color: Color.fromARGB(255, 9, 205, 16).withOpacity(0.9),
                    blurRadius: 10,
                    offset: Offset(5, 5),
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    blurRadius: 10,
                    offset: Offset(-5, -5),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    blurRadius: 10,
                    offset: Offset(5, 5),
                  ),
                ],
        ),
        child: Center(
          child: TextButton(
            onPressed: () {
              _startRotationAnimation();
              Future.delayed(Duration(milliseconds: 900), () {
                setState(() {
                  isTapped = true;
                });
                Get.to(() => Login());
              });
            },
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _controller.value * 2 * 3.1415926535,
                  child: ClipOval(
                    child: Image(
                      image: AssetImage(
                        isTapped
                            ? "assets/images/me3.jpg"
                            : "assets/images/me2.jpg",
                      ),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
