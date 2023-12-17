import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:whowhats/reusable/theme/theme.dart';
import 'package:whowhats/reusable/theme/theme_provider.dart';
import 'package:whowhats/screens/welcome.dart';

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
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(lightTheme, false),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    Provider.of<ThemeProvider>(context, listen: false).loadFromPrefs();

    return GetMaterialApp(
      title: 'Who-Whats',
      debugShowCheckedModeBanner: false,
      theme: themeProvider.getTheme(),
      initialRoute: 'welcome',
      home: Welcome(),
    );
  }
}
