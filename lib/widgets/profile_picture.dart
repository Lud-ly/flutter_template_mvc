import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:whowhats/widgets/rounded_image.dart';

import '../screen/login.dart';
import '../reusable/user_lib.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      key: Key("goToAccountButton"),
      child: kIsWeb ? _PhoneImg() : _WebImg(),
    );
  }
}

class _WebImg extends StatelessWidget {
  const _WebImg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // String picturePath = logged ? currentUser.photo : 'assets/images/user.png';
    String picturePath = 'assets/images/user.jpg';
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 5, 15, 0),
        child: IconButton(
          onPressed: () {
            // if (logged){
            //   Get.to(() => const AccountPage());
            // } else{
            //   Get.to(() => Login(AccountPage()));
            // }
          },
          icon: RoundedImage(
            picturePath,
            50,
            50,
          ),
          iconSize: 50,
        ));
  }
}

class _PhoneImg extends StatelessWidget {
  const _PhoneImg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double imgHeight = 10;
    // String picturePath = logged ? currentUser.photo : 'assets/images/user.png';
    String picturePath = 'assets/images/user.jpg';

    return Container(
      margin: const EdgeInsets.fromLTRB(0, 5, 30, 0),
      child: IconButton(
        onPressed: () {
          // if (logged){
          //   Get.to(() => const AccountPage());
          // } else{
          //   Get.to(() => const LoginPage(AccountPage()));
          // }
        },
        icon: RoundedImage(picturePath, imgHeight, imgHeight),
        iconSize: imgHeight,
      ),
    );
  }
}
