import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../reusable/lib_images.dart';
import '../utils/tools_lib.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  String picturePath = 'assets/images/user.jpg';
  Color customcolor = Color.fromARGB(255, 6, 20, 131);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "WW",
            style: GoogleFonts.permanentMarker(
              color: Colors.black,
              letterSpacing: 4,
              fontSize: 30, // Adjust the font size as needed
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(2.0, 2.0),
                  blurRadius: 1.0,
                  color: customcolor,
                ),
              ],
            ),
          ),
          CircleAvatar(
              radius: 25,
              backgroundColor: customcolor,
              child: CircleAvatar(
                  radius: 20, backgroundImage: AssetImage(picturePath)))
        ],
      ),
      backgroundColor: Colors.white, // Change the color as needed
      automaticallyImplyLeading: false, // Set to true if you want a back button
      elevation: 0, // Change the elevation as needed
    );
  }
}
