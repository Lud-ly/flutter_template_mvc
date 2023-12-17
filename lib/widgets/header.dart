import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whowhats/reusable/theme/theme_provider.dart';

class Header extends StatefulWidget {
  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'M',
            style: TextStyle(
                fontSize: 28,
                fontFamily: 'PermanentMarker',
                color: themeProvider.getTheme().highlightColor),
          ),
          Image(
            image: AssetImage("assets/images/distress.jpg"),
            width: 40,
            height: 40,
          ),
        ],
      ),

      backgroundColor: themeProvider.getTheme().primaryColor,
      automaticallyImplyLeading: false,
      elevation: 0, // C
      shape: Border(
        bottom: BorderSide(
          color: Colors.black,
          width: 2.0,
        ),
      ),
    );
  }
}
