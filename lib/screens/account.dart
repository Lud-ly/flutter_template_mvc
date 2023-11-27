import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:whowhats/api/firebase_services.dart';
import 'package:whowhats/screens/changeAvatar.dart';
import 'package:whowhats/screens/welcome.dart';

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
                'Mon compte !',
                style: TextStyle(
                    fontFamily: 'PermanentMarker',
                    color: Colors.black,
                    fontSize: 40),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.to(() => ChangeAvatarPage());
            },
            child: Text(
              'Changer son avatar',
              style:
                  TextStyle(fontFamily: 'PermanentMarker', color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () {
              FirebaseServices.disconnect();
              Get.to(() => Welcome());
            },
            child: Text(
              'Se deconnecter',
              style:
                  TextStyle(fontFamily: 'PermanentMarker', color: Colors.black),
            ),
          ),
        ],
      ),
      scrollController: _scrollController,
    );
  }
}
