import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screen/welcome.dart';
import 'screen/home.dart';
import 'screen/signup.dart';
import 'screen/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
          primary: const Color.fromRGBO(255, 93, 110, 1),
          secondary: const Color.fromRGBO(44, 55, 59, 1),
          tertiary: Color.fromARGB(255, 95, 231, 197),
        ),
        fontFamily: 'PermanentMarker',
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: 'welcome',
      routes: {
        'welcome': (context) => Welcome(),
        'registration': (context) => Registration(),
        'login': (context) => Login(),
        'home': (context) => Home()
      },
    );
  }
}
