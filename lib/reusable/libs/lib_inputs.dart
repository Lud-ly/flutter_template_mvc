import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LibInputs {
  static InputDecoration kTextFieldDecoration = InputDecoration(
      hintText: 'Entrée une valeur',
      hintStyle: TextStyle(color: Colors.black),
      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 3.0),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ));
}
