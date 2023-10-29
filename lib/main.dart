import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whowhats/screens/welcome.dart';
import 'auth/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: kIsWeb
          ? const FirebaseOptions(
              apiKey: "AIzaSyDYXVc7qT0qy2qGG6WxMLKq0mqCAsgC0go",
              projectId: "who-whats",
              messagingSenderId: "587216056098",
              appId: "1:587216056098:android:95de075c1ce70e8212bf7b")
          : const FirebaseOptions(
              apiKey: "AIzaSyDYXVc7qT0qy2qGG6WxMLKq0mqCAsgC0go",
              projectId: "who-whats",
              messagingSenderId: "587216056098",
              appId: "1:587216056098:android:95de075c1ce70e8212bf7b"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Who-Whats',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color.fromARGB(255, 6, 20, 131),
          secondary: const Color.fromRGBO(44, 55, 59, 1),
          tertiary: Color.fromARGB(255, 95, 231, 197),
        ),
        fontFamily: GoogleFonts.permanentMarker().toString(),
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: 'welcome',
      home: Welcome(),
    );
  }
}
