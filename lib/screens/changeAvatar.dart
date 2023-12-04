import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whowhats/reusable/libs/tools_lib.dart';
import 'package:whowhats/screens/home.dart';
import 'package:whowhats/utils/shortcuts.dart';
import '../reusable/customs/custom_scaffold.dart';

class ChangeAvatarPage extends StatefulWidget {
  @override
  _ChangeAvatarPageState createState() => _ChangeAvatarPageState();
}

class _ChangeAvatarPageState extends State<ChangeAvatarPage> {
  final _auth = FirebaseAuth.instance;
  late User loggedinUser;
  late ScrollController _scrollController;
  File? _image;
  final picker = ImagePicker();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    getCurrentUser();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedinUser = user;
        print(loggedinUser);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _uploadAvatar(ImageSource source) async {
    try {
      setState(() {
        isLoading = true;
      });

      final pickedFile = await picker.getImage(source: source);

      if (pickedFile != null) {
        _image = File(pickedFile.path);

        final Reference storageReference =
            FirebaseStorage.instance.ref().child('avatars/${loggedinUser.uid}');
        await storageReference.putFile(_image!);

        String downloadURL = await storageReference.getDownloadURL();
        print('Avatar URL: $downloadURL');
      }

      setState(() {
        isLoading = false;
      });

      Get.to(() => HomePage());
    } catch (e) {
      print('Error uploading avatar: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Changer votre avatar.',
                style: TextStyle(
                    fontFamily: 'PermanentMarker',
                    color: Colors.black,
                    fontSize: 30),
              ),
            ),
          ),
          ClipOval(
            child: _image != null
                ? Image.file(
                    _image!,
                    width: 200,
                    height: 200,
                  )
                : Image.asset(
                    "assets/images/me.png",
                    width: 200,
                    height: 200,
                  ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  foregroundColor: CodeShortcuts.getColor(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                onPressed: () => _uploadAvatar(ImageSource.camera),
                child: Text(
                  'Prendre une photo',
                  style: TextStyle(fontFamily: 'PermanentMarker'),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  foregroundColor: CodeShortcuts.getColor(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                onPressed: () => _uploadAvatar(ImageSource.gallery),
                child: Text(
                  'Sur le téléphone',
                  style: TextStyle(fontFamily: 'PermanentMarker'),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: () {
              setState(() {
                isLoading = true;
              });
              Future.delayed(Duration(milliseconds: 1200), () {
                setState(() {
                  isLoading = false;
                });
                Get.to(() => HomePage());
              });
            },
            child: !isLoading
                ? Text('Passer',
                    style: TextStyle(
                        fontFamily: 'PermanentMarker', color: Colors.black))
                : CircularProgressIndicator(
                    color: Color.fromARGB(255, 13, 240, 21),
                  ),
          ),
          SizedBox(height: 300),
        ],
      ),
      scrollController: _scrollController,
    );
  }
}
