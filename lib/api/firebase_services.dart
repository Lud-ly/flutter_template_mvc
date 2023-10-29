import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../utils/shortcuts.dart';

class FirebaseServices {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static bool? currentIsRetrievedFromBDD;

  static disconnect() {
    _auth.signOut();
  }

  static Future<String?> signInWithMail(
      String email, String mdp, BuildContext context) async {
    try {
      User? user =
          (await _auth.signInWithEmailAndPassword(email: email, password: mdp))
              .user;

      if (user != null) {
        return user.uid;
      }
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CodeShortcuts.toast("email existe pas", context);
      } else if (e.code == 'wrong-password') {
        CodeShortcuts.toast("mauvais password", context);
      }
      return null;
    }
  }

  static Future<String?> registerWithMail(
      String mail, String mdp, BuildContext context) async {
    try {
      User? user = (await _auth.createUserWithEmailAndPassword(
              email: mail, password: mdp))
          .user;

      if (user != null) {
        await FirebaseChatCore.instance.createUserInFirestore(
          types.User(
            firstName: "un prénom",
            id: user.uid,
            imageUrl: 'https://i.pravatar.cc/300?u=$mail',
            lastName: "un nom",
          ),
        );
        return user.uid;
      }
      return null;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'email-already-in-use') {
        CodeShortcuts.toast("email deja utilisé", context);
      } else if (e.code == 'invalid-email') {
        CodeShortcuts.toast("email invalide", context);
      } else if (e.code == 'operation-not-allowed') {
        CodeShortcuts.toast('Not enable', context);
      } else if (e.code == 'weak-password') {
        CodeShortcuts.toast("weakpassword", context);
      } else {
        CodeShortcuts.toast(e.code, context);
      }
      return null;
    }
  }
}
