import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:whowhats/screens/home.dart';
import 'package:whowhats/utils/tools_lib.dart';
import '../../widgets/header.dart';
import '../libs/lib_images.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../widgets/footer.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final ScrollController? scrollController;

  final _auth = FirebaseAuth.instance;
  CustomScaffold({required this.body, required this.scrollController, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: SCREEN_HEIGHT(context),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: HOMEBACKGROUND,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Header(),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(0),
                width: SCREEN_WIDTH(context),
                decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius:
                        BorderRadius.all(Radius.circular(kIsWeb ? 40 : 20))),
                child: body,
              ),
            ),
            Footer(
              scrollController,
            ),
          ],
        ),
      ),
      // ),
    );
  }
}

abstract class CustomHeader extends StatefulWidget {
  const CustomHeader({Key? key}) : super(key: key);
}
