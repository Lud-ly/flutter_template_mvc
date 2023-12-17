import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../reusable/customs/custom_scaffold.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = FirebaseAuth.instance;
  late User loggedinUser;
  late ScrollController _scrollController;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    // getCurrentUser();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Maintenance mode in on !',
                style: TextStyle(
                    fontFamily: 'PermanentMarker',
                    color: Colors.black,
                    fontSize: 20),
              ),
            ),
          ),
          SizedBox(height: 800),
        ],
      ),
      scrollController: _scrollController,
    );
  }
}
