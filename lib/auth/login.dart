import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/material.dart';
import 'package:whowhats/auth/registration.dart';
import 'package:whowhats/screens/home.dart';
import 'package:whowhats/utils/custom_textstyles.dart';

import '../reusable/shortcuts.dart';

//code for designing the UI of our text field where the user writes his email id or password

const kTextFieldDecoration = InputDecoration(
    hintText: 'Enter a value',
    hintStyle: TextStyle(color: Colors.grey),
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ));

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

final _auth = FirebaseAuth.instance;

class _LoginState extends State<Login> {
  late String email;
  late String password;
  late bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                  child: Text(
                "Connexion",
                style: GoogleFonts.permanentMarker(fontSize: 40),
              )),
              const Image(
                image: AssetImage("assets/images/undraw_breakfast_psiw.png"),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "WW",
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
                    ),
                  ),
                ),
              ),
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Votre email',
                  )),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Votre password.')),
              const SizedBox(
                height: 24.0,
              ),
              TextButton(
                  child: Text('Se connecter'),
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        Get.to(() => HomePage());
                      }
                    } catch (e) {
                      print(e);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  }),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  child: Text(
                    'S\'inscrire',
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.amber),
                    foregroundColor: CodeShortcuts.getColor(Colors.black),
                  ),
                  onPressed: () {
                    Get.to(() => Registration());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
