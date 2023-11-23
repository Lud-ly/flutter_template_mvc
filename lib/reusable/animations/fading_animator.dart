import 'package:fading_widget_animation/core/fading_widget.dart';
import 'package:flutter/material.dart';
import 'package:whowhats/reusable/miscellaneous/image_path.dart';

class WidgetFadingAnimator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FadingWidgetAnimator(
          duration: const Duration(seconds: 4),
          child: const Text(
            'Best Leagues',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // a simple method to make dots
            buildDots(
                duration: const Duration(seconds: 3),
                startAfter: const Duration(
                    seconds: 1), //this dot will load after 1 second
                color: Colors.purple,
                image: ImagePath("assets/images/Logo_Bundesliga.png")),
            const SizedBox(width: 5),
            buildDots(
                duration: const Duration(seconds: 3),
                startAfter: const Duration(
                    seconds: 2), //this dot will load after 2 seconds
                color: Colors.indigo,
                image: ImagePath("assets/images/Logo_Bundesliga.png")),
            const SizedBox(width: 5),
            buildDots(
                duration: const Duration(seconds: 3),
                startAfter: const Duration(
                    seconds: 3), //this dot will load after 3 seconds
                color: Colors.green,
                image: ImagePath("assets/images/Logo_Bundesliga.png")),
            const SizedBox(width: 5),
            buildDots(
                duration: const Duration(seconds: 3),
                startAfter: const Duration(
                    seconds: 4), //this dot will load after 4 seconds
                color: Colors.yellow,
                image: ImagePath("assets/images/Logo_Bundesliga.png")),
            const SizedBox(width: 5),
            buildDots(
                duration: const Duration(seconds: 3),
                startAfter: const Duration(
                    seconds: 5), //this dot will load after 5 seconds
                color: Colors.orange,
                image: ImagePath("assets/images/Logo_Bundesliga.png")),
            const SizedBox(width: 5),
            buildDots(
                duration: const Duration(seconds: 3),
                startAfter: const Duration(
                    seconds: 6), //this dot will load after 6 seconds
                color: Colors.red,
                image: ImagePath("assets/images/Logo_Bundesliga.png")),
          ],
        ),
      ],
    );
  }

  FadingWidgetAnimator buildDots(
      {required Duration duration,
      required Duration startAfter,
      required Color color,
      required ImagePath image}) {
    return FadingWidgetAnimator(
      duration: duration,
      startAfter: startAfter,
      child: CircleAvatar(
        radius: 55,
        backgroundColor: color,
        child: image,
      ),
    );
  }
}
