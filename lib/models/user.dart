import 'package:whowhats/models/adresse.dart';
import 'package:whowhats/reusable/lib_images.dart';

enum Role { admin, livreur, user }

class User {
  String uid;
  String firstName;
  String lastName;
  String email;
  String phone;
  late String photo;
  Adress adress;
  Role role;
  String notifToken;

  User(
      {required this.uid,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.phone,
      required this.adress,
      required this.role,
      required this.notifToken,
      String? photo}) {
    if (photo == null) {
      this.photo = PATH_USER_DEFAULT;
    } else {
      this.photo = photo;
    }
  }

  factory User.fromMap(Map<String, dynamic> data) {
    User user = User(
      uid: data["uid"],
      firstName: data["firstName"],
      lastName: data["lastName"],
      email: data["email"],
      phone: data["phone"],
      adress: Adress.fromMap(data["adress"]),
      role: Role.user,
      notifToken: data["notifToken"],
      photo: data["photo"],
    );

    if (data["photo"] != null && data["photo"] != "") {
      user.photo = data["photo"];
    }

    if (data["role"] == Role.admin.toString()) {
      user.role = Role.admin;
    } else if (data["role"] == Role.livreur.toString()) {
      user.role = Role.livreur;
    }
    return user;
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phone": phone,
      "photo": photo,
      "role": role.toString(),
      "notifToken": notifToken,
      "adress": adress.toMap(),
    };
  }
}
