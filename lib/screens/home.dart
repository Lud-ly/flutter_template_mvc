import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../reusable/custom_scaffold.dart';

late User loggedinUser;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = FirebaseAuth.instance;
  late ScrollController _scrollController;
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    _scrollController = ScrollController();
    Future.delayed(Duration.zero, () => _showExplanationDialog(context));
  }

  Future<void> _showExplanationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          true, // Permet de fermer le pop-up en cliquant en dehors
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white
              .withOpacity(0.9), // Fond blanc légèrement transparent
          title: Text(
            'Bienvenue !',
            style: TextStyle(
              fontFamily: 'PermanentMarker',
              color: Colors.black,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Bienvenue dans votre application. Nous vous invitons à changer votre avatar dans la page Mon compte si vous le souhaitez.',
                  style: TextStyle(
                    fontFamily: 'PermanentMarker',
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Fermer',
                style: TextStyle(
                  fontFamily: 'PermanentMarker',
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
          Text('dkdfldfdlk'),
        ],
      )),
      scrollController: _scrollController,
    );
  }
}
