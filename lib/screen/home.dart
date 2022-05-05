import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/custom_scaffold.dart';
import '../widgets/profile_picture.dart';

late User loggedinUser;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _auth = FirebaseAuth.instance;
  late ScrollController _scrollController;

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
      final user = await _auth.currentUser;
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
          children: [
            _Header(),
            Text("Who Whats", style: GoogleFonts.permanentMarker()),
          ],
        ),
      ),
      scrollController: _scrollController,
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const ProfilePicture(),
                    const SizedBox(width: kIsWeb ? 90 : 20),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.video_camera_back,
                          color: Theme.of(context).colorScheme.secondary),
                      iconSize: 30,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.phone,
                          color: Theme.of(context).colorScheme.secondary),
                      iconSize: 30,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.more_vert,
                          color: Theme.of(context).colorScheme.secondary),
                      iconSize: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
