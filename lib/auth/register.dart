import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:whowhats/api/firebase_services.dart';
import 'package:whowhats/auth/login.dart';
import 'package:whowhats/screens/home.dart';

import '../reusable/shortcuts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _registering = false;
  bool showSpinner = false;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    super.dispose();
  }

  void _register() {
    FocusScope.of(context).unfocus();

    setState(() {
      _registering = true;
    });

    String _email = _usernameController.text;
    String _password = _passwordController.text;
    String _firstName = _firstnameController.text;
    String _lastName = _lastnameController.text;

    FirebaseServices.registerWithMail(
            _email, _password, _firstName, _lastName, context)
        .then((userId) {
      if (userId != null) {
        Get.to(() => HomePage());
      } else {
        setState(() {
          _registering = false;
        });
      }
    }).catchError((error) {
      setState(() {
        _registering = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ModalProgressHUD(
          color: Colors.black,
          progressIndicator: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
                Colors.deepOrangeAccent), // Color of the loader
          ),
          inAsyncCall: showSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 60,
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
                        Get.to(() => Login());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Se connecter',
                            style: TextStyle(
                              fontFamily: 'PermanentMarker',
                              fontSize: 10,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Icon(
                            Icons.login_outlined,
                            color: Colors.black,
                            size: 18.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                    child: Text(
                  "Inscription",
                  style: TextStyle(
                      fontFamily: 'PermanentMarker',
                      fontSize: 40,
                      color: Colors.black),
                )),
                SizedBox(
                  height: 50,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
                        controller: _lastnameController,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            labelText: 'Nom',
                            labelStyle: TextStyle(color: Colors.black),
                            suffixIcon: IconButton(
                              color: Colors.black,
                              icon: const Icon(Icons.cancel),
                              onPressed: () => _lastnameController.clear(),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 4.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                            )),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre nom';
                          } else if (value.length < 3) {
                            return 'Le nom est trop court';
                          }
                          return null;
                        },
                        onEditingComplete: () {
                          if (_formKey.currentState!.validate()) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _firstnameController,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            labelText: 'Prénom',
                            labelStyle: TextStyle(color: Colors.black),
                            suffixIcon: IconButton(
                              color: Colors.black,
                              icon: const Icon(Icons.cancel),
                              onPressed: () => _firstnameController.clear(),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 4.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                            )),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre nom';
                          } else if (value.length < 3) {
                            return 'Le nom est trop court';
                          }
                          return null;
                        },
                        onEditingComplete: () {
                          if (_formKey.currentState!.validate()) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.black),
                            suffixIcon: IconButton(
                              color: Colors.black,
                              icon: const Icon(Icons.cancel),
                              onPressed: () => _usernameController.clear(),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 4.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                            )),
                        keyboardType: TextInputType.emailAddress,
                        onEditingComplete: () =>
                            FocusScope.of(context).nextFocus(),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.black),
                            suffixIcon: IconButton(
                              color: Colors.black,
                              icon: const Icon(Icons.cancel),
                              onPressed: () => _passwordController.clear(),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 4.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                            )),
                        obscureText: true,
                        onEditingComplete: _register,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      TextButton(
                        onPressed: _registering ? null : _register,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                          foregroundColor: CodeShortcuts.getColor(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Ajustez le rayon selon vos besoins
                            ),
                          ),
                        ),
                        child: Text(
                          'Crée mon compte',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
