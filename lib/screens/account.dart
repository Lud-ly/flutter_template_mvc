import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:whowhats/api/firebase_services.dart';
import 'package:whowhats/reusable/libs/tools_lib.dart';
import 'package:whowhats/reusable/miscellaneous/custom_textstyles.dart';
import 'package:whowhats/reusable/theme/theme.dart';
import 'package:whowhats/reusable/theme/theme_provider.dart';
import 'package:whowhats/screens/welcome.dart';
import 'package:whowhats/utils/row_button.dart';

import '../reusable/customs/custom_scaffold.dart';

late User loggedinUser;

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _auth = FirebaseAuth.instance;
  late ScrollController _scrollController;
  String imageUrl = "assets/images/user.png";
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return CustomScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Mon compte',
                style: TextStyle(
                    fontFamily: 'PermanentMarker',
                    color: themeProvider.getTheme().highlightColor,
                    fontSize: 23),
              ),
            ),
          ),
          RowButton(
            Icon(
              themeProvider.isLightTheme()
                  ? Icons.sunny
                  : Icons.dark_mode_outlined,
              color: themeProvider.getTheme().highlightColor,
              size: kIsWeb ? 60 : 20,
            ),
            themeProvider.isLightTheme() ? "Light" : "Dark",
            () {
              themeProvider.toggleTheme();
            },
            Colors.transparent,
            TextStyle(
              fontFamily: 'PermanentMarker',
              color: themeProvider.getTheme().highlightColor,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'Changer son avatar',
              style: TextStyle(
                fontFamily: 'PermanentMarker',
                color: themeProvider.getTheme().highlightColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              FirebaseServices.disconnect();
              Get.to(() => Welcome());
            },
            child: Text(
              'Se deconnecter',
              style: TextStyle(
                fontFamily: 'PermanentMarker',
                color: themeProvider.getTheme().highlightColor,
              ),
            ),
          ),
          SizedBox(height: 500),
        ],
      ),
      scrollController: _scrollController,
    );
  }
}
