import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:whowhats/api/firebase_services.dart';
import 'package:whowhats/auth/login.dart';
import 'package:whowhats/screens/home.dart';
import 'package:whowhats/utils/custom_textstyles.dart';

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
          inAsyncCall: showSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Center(
                      child: Text(
                    "S'inscrire",
                    style: GoogleFonts.permanentMarker(
                        fontSize: 40, color: Colors.black),
                  )),
                  const Image(
                    image:
                        AssetImage("assets/images/undraw_breakfast_psiw.png"),
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
                  TextFormField(
                    controller: _lastnameController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      labelText: 'Nom',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () => _lastnameController.clear(),
                      ),
                    ),
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
                  TextFormField(
                    controller: _firstnameController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      labelText: 'Prénom',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () => _firstnameController.clear(),
                      ),
                    ),
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
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      labelText: 'Email',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () => _usernameController.clear(),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () => _passwordController.clear(),
                      ),
                    ),
                    obscureText: true,
                    onEditingComplete: _register,
                  ),
                  TextButton(
                    onPressed: _registering ? null : _register,
                    child: Text(
                      'Crée mon compte',
                      style: CustomTextStyle.small(fontColor: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondary,
                        padding: const EdgeInsets.all(2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      child: Text('Déja un compte ? Se connecter',
                          style: TextStyle(
                            color: primary,
                            fontFamily: 'fantasy',
                          )),
                      onPressed: () {
                        Get.to(() => Login());
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
