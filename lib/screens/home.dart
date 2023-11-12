import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../reusable/custom_scaffold.dart';

late User loggedinUser;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = FirebaseAuth.instance;
  late ScrollController _scrollController;
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    _scrollController = ScrollController();
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

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection(
                  'users') // Remplacez par le nom de votre collection d'utilisateurs
              .doc(loggedinUser.uid)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Vous pouvez également afficher un indicateur de chargement ici
            } else if (snapshot.hasError) {
              return Text('Erreur de chargement des données de l\'utilisateur');
            } else if (!snapshot.hasData || !snapshot.data!.exists) {
              return Text('Aucune donnée utilisateur trouvée');
            } else {
              Map<String, dynamic> userData =
                  snapshot.data!.data() as Map<String, dynamic>;
              String firstName = userData['firstName'];
              String lastName = userData['lastName'];
              imageUrl = userData['imageUrl'];

              print('User Data: $firstName $lastName $imageUrl');

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Bienvenue, $firstName $lastName!',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              );
            }
          },
        ),
      ),
      scrollController: _scrollController,
      imageUrl: imageUrl,
    );
  }
}
