import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:whowhats/models/user.dart';

class Current extends ChangeNotifier {
  Role chosenRole = Role.user;
  User? currentUser;

  User? get user {
    return currentUser;
  }
}

//this is only to be used outside a widget
Current getCurrent(BuildContext context) {
  return Provider.of<Current>(context, listen: false);
}
