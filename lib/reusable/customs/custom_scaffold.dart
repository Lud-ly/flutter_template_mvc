import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:whowhats/reusable/libs/tools_lib.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whowhats/widgets/header.dart';

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
      extendBody: true,
      body: Column(
        children: [
          Header(),
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              child: Container(
                padding: const EdgeInsets.all(0),
                width: SCREEN_WIDTH(context),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius:
                      BorderRadius.all(Radius.circular(kIsWeb ? 40 : 20)),
                ),
                child: body,
              ),
            ),
          ),
          Footer(
            scrollController!,
          ),
        ],
      ),
    );
  }
}
