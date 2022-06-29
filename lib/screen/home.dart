import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whowhats/data/ldap.dart';
import 'package:whowhats/models/team_model.dart';
import 'package:whowhats/screen/leagues/bundesliga.dart';
import 'package:whowhats/screen/leagues/laliga.dart';
import 'package:whowhats/screen/leagues/ligue1.dart';
import 'package:whowhats/screen/leagues/premierleague.dart';
import 'package:whowhats/screen/leagues/serieA/grid/teams_list.dart';
import 'package:whowhats/screen/leagues/serieA/serieA.dart';
import 'package:whowhats/utils/tools_lib.dart';

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

  // List<Team> get _forYouArticles => _forYouArticles;

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
      body: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            decoration: BoxDecoration(color: Color.fromARGB(255, 80, 243, 255)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const _Header(),
                SizedBox(
                    child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: Text("Footdata",
                      style: GoogleFonts.permanentMarker(
                        color: Colors.white,
                        fontSize: 35,
                        shadows: <Shadow>[
                          const Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 1.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ],
                      )),
                )),
                const MenuLeague(),
                // TeamsList(
                //   _forYouArticles,
                // ),
              ],
            ),
          )),
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage("assets/images/logo.png"),
                      width: 80,
                    ),
                    const ProfilePicture(),
                    IconButton(
                      onPressed: () {},
                      icon: const Image(
                        image: AssetImage(
                            "assets/images/undraw_handcrafts_file.png"),
                      ),
                      iconSize: 50,
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

class MenuLeague extends StatelessWidget {
  const MenuLeague({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: LDAP.categories.map((item) {
              return Container(
                color: Colors.white,
                margin: const EdgeInsets.only(right: 35),
                child: InkWell(
                  splashColor: COLOR_PRIMARY(context),
                  onTap: () {
                    switch (item.name) {
                      case "LaLiga":
                        Get.to(() => Laliga());
                        break;
                      case "PremiereLeague":
                        Get.to(() => PremierLeague());
                        break;
                      case "Ligue1":
                        Get.to(() => Ligue1());
                        break;
                      case "SerieA":
                        Get.to(() => SerieA());
                        break;
                      case "Bundesliga":
                        Get.to(() => Bundesliga());
                        break;
                    }
                  },
                  child: Row(
                    children: [
                      // Text(item.name, style: CustomTextStyle.medium()),

                      Image.asset(
                        item.imagePath,
                        scale: 3,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
