// ignore_for_file: constant_identifier_names, deprecated_member_use

import 'package:flutter/material.dart';

const Color kWhiteColor = Colors.white;
const Color kBlackColor = Colors.black;
const Color kGreenColor = Colors.greenAccent;

ThemeData lightTheme = ThemeData(
  primaryColor: kWhiteColor,
  scaffoldBackgroundColor: kWhiteColor,
  backgroundColor: kWhiteColor,
  primaryColorLight: kWhiteColor,
  highlightColor: kBlackColor,
  iconTheme: const IconThemeData(color: kBlackColor),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: kWhiteColor, fontFamily: 'Roboto'),
    bodyText2: TextStyle(color: kBlackColor, fontFamily: 'Roboto'),
  ),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
      .copyWith(background: kWhiteColor),
);

ThemeData darkTheme = ThemeData(
  primaryColor: kBlackColor,
  scaffoldBackgroundColor: Colors.black,
  highlightColor: kWhiteColor,
  backgroundColor: kBlackColor,
  primaryColorLight: kBlackColor,
  iconTheme: const IconThemeData(color: kWhiteColor),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: kWhiteColor, fontFamily: 'Roboto'),
    bodyText2:
        TextStyle(color: kWhiteColor, fontFamily: 'Roboto', fontSize: 15),
  ),
);
