import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:whowhats/screens/home.dart';
import '../reusable/customs/custom_scaffold.dart';

class ChangeAvatarPage extends StatefulWidget {
  @override
  _ChangeAvatarPageState createState() => _ChangeAvatarPageState();
}

class _ChangeAvatarPageState extends State<ChangeAvatarPage> {
  final _auth = FirebaseAuth.instance;
  late User loggedinUser;
  late ScrollController _scrollController;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    getCurrentUser();
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
          SizedBox(height: 50),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Bienvenue !',
                style: TextStyle(
                    fontFamily: 'PermanentMarker',
                    color: Colors.black,
                    fontSize: 40),
              ),
            ),
          ),
          ClipOval(
            child: Image(
              image: AssetImage("assets/images/me.png"),
              width: 100,
              height: 100,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Nous vous invitons à changer votre avatar dans la page Mon compte si vous le souhaitez.',
                style: TextStyle(
                    fontFamily: 'PermanentMarker',
                    color: Colors.black,
                    fontSize: 30),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                isLoading = true;
              });
              Future.delayed(Duration(milliseconds: 1200), () {
                setState(() {
                  isLoading = false;
                });
                Get.to(() => HomePage());
              });
            },
            child: !isLoading
                ? Text('Passer',
                    style: TextStyle(
                        fontFamily: 'PermanentMarker', color: Colors.black))
                : CircularProgressIndicator(
                    color: Color.fromARGB(255, 13, 240, 21),
                  ),
          ),
        ],
      ),
      scrollController: _scrollController,
    );
  }
}
