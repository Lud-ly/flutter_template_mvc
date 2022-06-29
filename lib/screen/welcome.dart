import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:whowhats/auth/login.dart';
import 'package:whowhats/auth/register.dart';
import 'package:get/get.dart';
import 'package:whowhats/reusable/lib_images.dart';
import 'package:whowhats/widgets/custom_scaffold.dart';
import 'package:whowhats/widgets/rounded_image.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            image: BACKGROUND2,
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Get.to(() => RegisterPage());
                },
                icon: Image(
                    image:
                        AssetImage("assets/images/undraw_handcrafts_user.png"),
                    width: 60,
                    alignment: Alignment.center),
                //icon data for elevated button
                label: Text("S'inscrire"), //label text
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.tertiary,
                    elevation: 2 //elevated btton background color
                    ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Get.to(() => Login());
                },
                label: Text("Se connecter"), //label text
                icon: Image(
                    image: AssetImage(
                        "assets/images/undraw_handcrafts_curved_arrow.png"),
                    width: 50,
                    alignment:
                        Alignment.center), //icon data for elevated button
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.tertiary,
                    elevation: 2 //elevated btton background color
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
