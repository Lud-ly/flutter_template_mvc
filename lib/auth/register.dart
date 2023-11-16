import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:whowhats/api/firebase_services.dart';
import 'package:whowhats/auth/login.dart';
import 'package:whowhats/screens/home.dart';
import 'package:whowhats/utils/tools_lib.dart';

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
  late String errorMessage = '';
  bool _passwordVisible = false;

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
      showSpinner = true;
      errorMessage = '';
    });

    if (_formKey.currentState!.validate()) {
      String _email = _usernameController.text;
      String _password = _passwordController.text;
      String _firstName = _firstnameController.text;
      String _lastName = _lastnameController.text;

      FirebaseServices.registerWithMail(
              _email, _password, _firstName, _lastName, context)
          .then((userId) {
        _registering = true;
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
          showSpinner = false;
        });

        // Gestion des erreurs
        if (error is FirebaseAuthException) {
          _registering = false;
          showSpinner = false;
          switch (error.code) {
            case 'email-already-in-use':
              errorMessage = 'Cette adresse e-mail est déjà enregistrée.';
              break;
            case 'weak-password':
              errorMessage =
                  'Le mot de passe est trop faible. Il doit comporter au moins 6 caractères.';
              break;
            default:
              errorMessage = 'Erreur lors de l\'inscription : ${error.message}';
          }
        } else {
          errorMessage = 'Erreur inattendue : ${error.toString()}';
        }
      });
    }
  }

  String? validateName(String? value, String fieldName) {
    showSpinner = false;
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer votre $fieldName.';
    } else if (value.length < 3) {
      return 'Le $fieldName est trop court.';
    }
    _registering = false;
    return null;
  }

  String? validateEmail(String? value) {
    showSpinner = false;
    _registering = false;
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer votre @dresse e-mail.';
    } else if (!isValidEmail(value)) {
      return 'Veuillez entrer une adresse e-mail v@lide.';
    }
    return null;
  }

  String? validatePassword(String? value) {
    showSpinner = false;
    _registering = false;
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer votre mot de passe.';
    } else if (value.length < 6) {
      return 'Il doit comporter au moins 6 caractères';
    } else if (!isValidPassword(value)) {
      return 'trop faible, au moins une majuscule et un chiffre.';
    }
    return null;
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType? keyboardType,
    bool obscureText = false,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 3,
            color: Colors.deepOrangeAccent,
          ),
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        errorStyle: TextStyle(
          color: Colors.deepOrangeAccent,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.black),
        suffixIcon: IconButton(
          color: Colors.black,
          icon: const Icon(Icons.cancel),
          onPressed: () => controller.clear(),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 4.0),
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      onEditingComplete: () {
        if (_formKey.currentState!.validate()) {
          FocusScope.of(context).nextFocus();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        color: Colors.black,
        progressIndicator: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
        ),
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                // Cacher le clavier lorsque l'utilisateur clique à l'extérieur du champ de texte.
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Column(
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
                    height: 40,
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
                    height: 30,
                  ),
                  Form(
                    key: _formKey,
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        buildTextField(
                          controller: _lastnameController,
                          labelText: 'Nom',
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            return validateName(value, 'Nom');
                          },
                        ),
                        const SizedBox(height: 15),
                        buildTextField(
                          controller: _firstnameController,
                          labelText: 'Prénom',
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            return validateName(value, 'Prénom');
                          },
                        ),
                        const SizedBox(height: 15),
                        buildTextField(
                          controller: _usernameController,
                          labelText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            return validateEmail(value);
                          },
                        ),
                        const SizedBox(height: 15),
                        // TextFormField(
                        //   obscureText: !_passwordVisible,
                        //   validator: (value) {
                        //     return validatePassword(value);
                        //   },
                        //   decoration: InputDecoration(
                        //     hintText: "passwordExemple82",
                        //     labelText: "password",
                        //     border: const OutlineInputBorder(
                        //       borderRadius:
                        //           BorderRadius.all(Radius.circular(8)),
                        //     ),
                        //     labelStyle: TextStyle(color: Colors.black),
                        //     suffixIcon: IconButton(
                        //       icon: Icon(
                        //         _passwordVisible
                        //             ? Icons.visibility
                        //             : Icons.visibility_off,
                        //         color: Colors.black,
                        //       ),
                        //       onPressed: () {
                        //         setState(() {
                        //           _passwordVisible = !_passwordVisible;
                        //         });
                        //       },
                        //     ),
                        //     enabledBorder: OutlineInputBorder(
                        //       borderSide:
                        //           BorderSide(color: Colors.black, width: 2.0),
                        //       borderRadius:
                        //           BorderRadius.all(Radius.circular(12.0)),
                        //     ),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderSide:
                        //           BorderSide(color: Colors.black, width: 4.0),
                        //       borderRadius:
                        //           BorderRadius.all(Radius.circular(12.0)),
                        //     ),
                        //   ),
                        // ),
                        buildTextField(
                          controller: _passwordController,
                          labelText: 'Password',
                          obscureText: true,
                          validator: (value) {
                            return validatePassword(value);
                          },
                        ),
                        SizedBox(
                          height: 52,
                        ),
                        TextButton(
                          onPressed: _registering ? null : _register,
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                            foregroundColor:
                                CodeShortcuts.getColor(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          child: _registering
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.deepOrangeAccent),
                                )
                              : Text(
                                  'Créer mon compte',
                                ),
                        ),

                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    RegExp emailRegex =
        RegExp(r"^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$");
    return emailRegex.hasMatch(email);
  }

  bool isValidPassword(String password) {
// si le mot de passe a au moins une lettre majuscule, une lettre minuscule et un chiffre
    return password.length >= 6 &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[0-9]'));
  }
}
