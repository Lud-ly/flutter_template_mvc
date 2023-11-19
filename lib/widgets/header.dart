import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Header extends StatefulWidget {
  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final _auth = FirebaseAuth.instance;

  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    User? loggedinUser = FirebaseAuth.instance.currentUser;

    return AppBar(
      title: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(loggedinUser!.uid)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Erreur de chargement des données de l\'utilisateur');
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return Text('Aucune donnée utilisateur trouvée');
          } else {
            Map<String, dynamic> userData =
                snapshot.data!.data() as Map<String, dynamic>;
            String firstName = userData['firstName'];
            String lastName = userData['lastName'];
            String imageUrl = userData['imageUrl'];

            print('User Data: $firstName $lastName $imageUrl');

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '$firstName $lastName',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'PermanentMarker',
                      color: Colors.black),
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(imageUrl),
                ),
              ],
            );
          }
        },
      ),
      backgroundColor: Colors.white, // Change the color as needed
      automaticallyImplyLeading: false, // Set to true if you want a back button
      elevation: 0, // C
    );
  }
}
