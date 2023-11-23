import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../reusable/miscellaneous/shortcuts.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _loading = false;

  void _sendResetEmail() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });

      try {
        await _auth.sendPasswordResetEmail(email: _emailController.text.trim());
        // L'e-mail de réinitialisation du mot de passe a été envoyé avec succès.
        // le 23/11/2023 to do : rediriger vers une autre page.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('E-mail de réinitialisation du mot de passe envoyé.'),
          ),
        );
      } catch (error) {
        // Gérer les erreurs lors de l'envoi de l'e-mail de réinitialisation du mot de passe.
        print(
            'Erreur lors de l\'envoi de l\'e-mail de réinitialisation : $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Erreur lors de l\'envoi, l\'e-mail ne correspond pas.'),
          ),
        );
      } finally {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Mot de passe oublié ?',
          style: TextStyle(fontFamily: 'PermanentMarker'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Votre Adresse e-mail',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre adresse e-mail.';
                  } else if (!RegExp(
                          r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                      .hasMatch(value)) {
                    return 'Veuillez entrer une adresse e-mail valide.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loading ? null : _sendResetEmail,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  foregroundColor: CodeShortcuts.getColor(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: Text('Réinitialiser le mot de passe'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
