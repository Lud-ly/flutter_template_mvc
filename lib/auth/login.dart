import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/material.dart';
import 'package:whowhats/auth/password.dart';
import 'package:whowhats/auth/register.dart';
import 'package:whowhats/api/login_service.dart';
import 'package:whowhats/reusable/animations/bounced_icon.dart';
import 'package:whowhats/reusable/libs/tools_lib.dart';
import 'package:whowhats/screens/home.dart';
import 'package:whowhats/utils/shortcuts.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

LoginService _authService = LoginService();

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
          valueColor:
              AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 13, 240, 21)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Get.to(() => RegisterPage());
                        },
                        child: BouncingIcon(
                          shape: Icons.edit,
                          SizeIcon: 22.0,
                          text: 'S\'incrire',
                          fSize: 12.0,
                          beginPosition: -6,
                          endPosition: -2,
                          duration: 500,
                        )),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Connexion",
                    style: TextStyle(
                        fontFamily: 'PermanentMarker',
                        fontSize: 20,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 90,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 23,
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
                                content: Text('email valide ?'),
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
                        hintText: "Exemple99",
                        labelText: "Mot de passe",
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
                  height: SCREEN_HEIGHT(context) * 0.17,
                ),
                TextButton(
                    child: Text(
                      'Se connecter',
                      style: TextStyle(
                        fontFamily: 'PermanentMarker',
                      ),
                    ),
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
                        final user = await _authService
                            .signInWithEmailAndPassword(email, password);
                        if (user != null) {
                          // Récupérer l'ID de l'utilisateur après la connexion réussie
                          String userId = await _authService.getUserId() ?? '';
                          print('User ID: $userId');
                          Get.to(() => HomePage());
                        }
                      } on FirebaseAuthException catch (e) {
                        print(e);
                        setState(() {
                          // Gestion des erreurs
                          errorMessage = _authService.getErrorMessage(e);
                        });
                      } catch (e) {
                        print(e);
                        setState(() {
                          // Gestion des autres erreurs
                          errorMessage = 'Erreur inconnue : ${e.toString()}';
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
