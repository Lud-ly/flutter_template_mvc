import 'package:flutter/cupertino.dart';
import 'package:whowhats/models/user.dart';

class Globals {
  static String? authToken;
  static String? notifToken;
  static User? user;
  static bool logged = false;

  static void initSocket(BuildContext context) {
    if (user == null) {
      return;
    }
  }
}
