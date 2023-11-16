import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/material.dart';
import 'package:whowhats/auth/password.dart';
import 'package:whowhats/auth/register.dart';
import 'package:whowhats/screens/home.dart';
import 'package:whowhats/utils/tools_lib.dart';

import '../reusable/lib_inputs.dart';
import '../reusable/shortcuts.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

final _auth = FirebaseAuth.instance;

class _LoginState extends State<Login> {
  late String email;
  late String password;
  bool _passwordVisible = false;

  late bool showSpinner = false;
  late String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        color: Colors.black,
        progressIndicator: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipOval(
                      child: Image(
                        image: AssetImage("assets/images/me.png"),
                        width: 40,
                        height: 40,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => RegisterPage());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'S\'inscrire',
                            style: TextStyle(
                              fontFamily: 'PermanentMarker',
                              fontSize: 10,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Icon(
                            Icons.edit,
                            color: Colors.black,
                            size: 18.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Text(
                    "Connexion",
                    style: TextStyle(
                        fontFamily: 'PermanentMarker',
                        fontSize: 40,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        if (!value.isEmpty || !value.isEmail) {
                          email = value;
                          setState(() {
                            errorMessage = '';
                          });
                        } else {
                          setState(() {
                            errorMessage = 'email invalide';
                          });
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "mail@ex.com",
                        labelText: "email",
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        labelStyle: TextStyle(color: Colors.black),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Tu ne sais pas ce qu\'est une adresse email ?'),
                              ),
                            );
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 4.0),
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        hintText: "passwordExemple82",
                        labelText: "password",
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        labelStyle: TextStyle(color: Colors.black),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 4.0),
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                      ),
                      onChanged: (value) {
                        password = value;
                        //Do something with the user input.
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: SCREEN_HEIGHT(context) * 0.27,
                ),
                TextButton(
                    child: Text('Se connecter'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      foregroundColor: CodeShortcuts.getColor(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                        errorMessage = '';
                      });
                      try {
                        final user = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        if (user != null) {
                          Get.to(() => HomePage());
                        }
                      } catch (e) {
                        print(e);
                        setState(() {
                          if (e is FirebaseAuthException) {
                            switch (e.code) {
                              case 'invalid-email':
                                errorMessage =
                                    'Adresse e-mail invalide. Veuillez vérifier.';
                                break;
                              case 'user-not-found':
                                errorMessage =
                                    'Aucun utilisateur trouvé avec cette adresse e-mail.';
                                break;
                              case 'wrong-password':
                                errorMessage =
                                    'Mot de passe incorrect. Veuillez réessayer.';
                                break;
                              case 'user-disabled':
                                errorMessage =
                                    'Ce compte utilisateur a été désactivé.';
                                break;
                              default:
                                errorMessage =
                                    'Erreur lors de la connexion : ${e.message}';
                                break;
                            }
                          } else {
                            print(e.toString());
                            errorMessage = 'Les champs ne peuvent être vide';
                          }
                        });
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    }),
                // Affiche le message d'erreur s'il y en a un
                errorMessage.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          errorMessage,
                          style: TextStyle(
                            color: Colors.deepOrangeAccent,
                            fontSize: 14.0,
                          ),
                        ),
                      )
                    : Container(),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotPasswordPage()),
                    );
                  },
                  child: Text(
                    'Mot de passe oublié?',
                    style: TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
