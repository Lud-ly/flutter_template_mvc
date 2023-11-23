import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../reusable/customs/custom_scaffold.dart';

late User loggedinUser;

class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  final _auth = FirebaseAuth.instance;
  late ScrollController _scrollController;
  String imageUrl = "assets/images/user.png";
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  //using this function you can use the credentials of the user
  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedinUser = user;
        print(loggedinUser);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: Text("Alarm page"),
      ),
      scrollController: _scrollController,
    );
  }
}
