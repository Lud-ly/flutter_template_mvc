import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:whowhats/screen/login.dart';
import 'package:whowhats/screen/signup.dart';
import 'package:get/get.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    const topColor = Colors.black26;
    const bottomColor = Colors.white10;

    return Scaffold(
      // backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: 30),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/undraw_handcrafts_welcome.png"),
            fit: BoxFit.contain,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Image(
                image: AssetImage("assets/images/undraw_breakfast_psiw.png"),
              ),
              ElevatedButton.icon(
                label: const Text(
                  "Enter",
                  style: TextStyle(fontSize: 14, color: Colors.black12),
                ),
                icon: Icon(
                  Icons.login_outlined,
                  size: 30,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {
                  Get.to(() => Login());
                },
              ),
              ElevatedButton.icon(
                label: const Text(
                  "S'inscrire",
                  style: TextStyle(fontSize: 14, color: Colors.black12),
                ),
                icon: Icon(
                  Icons.app_registration_rounded,
                  size: 30,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {
                  Get.to(() => Registration());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
