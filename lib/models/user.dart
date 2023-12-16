import 'package:whowhats/models/adresse.dart';
import 'package:whowhats/reusable/libs/lib_images.dart';

enum Role { admin, user }

class User {
  String uid;
  String firstName;
  String lastName;
  String email;
  String phone;
  late String imageUrl;
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
      String? imageUrl}) {
    if (imageUrl == null) {
      this.imageUrl = PATH_USER_DEFAULT;
    } else {
      this.imageUrl = imageUrl;
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
      imageUrl: data["imageUrl"],
    );

    if (data["imageUrl"] != null && data["imageUrl"] != "") {
      user.imageUrl = data["imageUrl"];
    }

    if (data["role"] == Role.admin.toString()) {
      user.role = Role.admin;
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
      "imageUrl": imageUrl,
      "role": role.toString(),
      "notifToken": notifToken,
      "adress": adress.toMap(),
    };
  }
}
