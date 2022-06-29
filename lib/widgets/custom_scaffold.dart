import 'package:flutter/material.dart';
import '../reusable/lib_images.dart';
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
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
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
