import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:whowhats/screens/home.dart';
import 'package:whowhats/utils/tools_lib.dart';
import '../widgets/header.dart';
import 'lib_images.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/footer.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final ScrollController? scrollController;
  final String imageUrl;
  final _auth = FirebaseAuth.instance;
  CustomScaffold(
      {required this.body,
      required this.scrollController,
      required this.imageUrl,
      Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),

      body: Center(
        child:
            // Container(
            //   height: SCREEN_HEIGHT(context),
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       image: BACKGROUND,
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            //   child:
            Column(
          children: [
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
