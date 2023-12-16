import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'MVC',
            style: TextStyle(
                fontSize: 28,
                fontFamily: 'PermanentMarker',
                color: Colors.black),
          ),
          ClipOval(
            child: Image(
              image: AssetImage("assets/images/me.png"),
              width: 40,
              height: 40,
            ),
          ),
        ],
      ),

      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      elevation: 0, // C
      shape: Border(
        bottom: BorderSide(
          color: Colors.black,
          width: 4.0,
        ),
      ),
    );
  }
}
