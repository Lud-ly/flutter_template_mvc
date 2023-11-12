import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whowhats/utils/custom_textstyles.dart';

import '../auth/login.dart';

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

class GoButton3D extends StatefulWidget {
  @override
  _GoButton3DState createState() => _GoButton3DState();
}

class _GoButton3DState extends State<GoButton3D> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          isTapped = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          isTapped = false;
        });
      },
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
                    Color.fromARGB(208, 255, 255, 255),
                    Color.fromARGB(189, 255, 255, 255)
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
                    color: Colors.white.withOpacity(0.9),
                    blurRadius: 10,
                    offset: Offset(5, 5),
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.6),
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
              onPressed: () => Get.to(() => Login()),
              child: Icon(
                Icons.add_to_home_screen_rounded,
                color: Colors.black,
                size: 60,
              )),
        ),
      ),
    );
  }
}
