import 'package:flutter/material.dart';
import '../reusable/images_lib.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'footer.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final ScrollController? scrollController;
  final _auth = FirebaseAuth.instance;
  CustomScaffold({required this.body, required this.scrollController, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: null,
      //   actions: <Widget>[
      //     IconButton(
      //         icon: const Image(
      //           image: AssetImage("assets/images/undraw_handcrafts_delete.png"),
      //           height: 20,
      //         ),
      //         onPressed: () {
      //           _auth.signOut();
      //           Navigator.pop(context);

      //           //Implement logout functionality
      //         }),
      //   ],
      //   title: Text('Home Page'),
      //   backgroundColor: Colors.lightBlueAccent,
      // ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: BACKGROUND,
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Expanded(child: body),
              Footer(
                scrollController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
