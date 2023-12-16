import 'package:firebase_auth/firebase_auth.dart';

class LoginService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // Capturer les erreurs Firebase Authentication et renvoyer le message d'erreur
      return null;
    } catch (e) {
      // Capturer d'autres erreurs et renvoyer le message d'erreur générique
      return null;
    }
  }

  Future<String?> getUserId() async {
    User? user = _auth.currentUser;
    return user?.uid;
  }

  // Ajouter une méthode pour obtenir le message d'erreur
  String getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'Adresse e-mail invalide. Veuillez vérifier.';
      case 'user-not-found':
        return 'Aucun utilisateur trouvé avec cette adresse e-mail.';
      case 'wrong-password':
        return 'Mot de passe incorrect. Veuillez réessayer.';
      case 'user-disabled':
        return 'Ce compte utilisateur a été désactivé.';
      default:
        return 'Erreur lors de la connexion : ${e.message}';
    }
  }
}
