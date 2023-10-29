import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../reusable/custom_scaffold.dart';

late User loggedinUser;

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _auth = FirebaseAuth.instance;
  late ScrollController _scrollController;

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
        child: Text("Account page"),
      ),
      scrollController: _scrollController,
    );
  }
}
