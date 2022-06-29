import 'dart:convert';

class Team {
  Team({
    required this.id,
    required this.name,
    required this.shortName,
    required this.phone,
    required this.crestUrl,
    required this.address,
    required this.website,
    required this.email,
    required this.founded,
    required this.clubColors,
    required this.venue,
  });

  int id;
  String name;
  String shortName;
  String phone;
  String crestUrl;
  String address;
  String website;
  String email;
  String clubColors;
  int? founded;
  String? venue;

  factory Team.fromJson(String str) => Team.fromMap(json.decode(str));

  factory Team.fromMap(Map<String, dynamic> json) => Team(
        id: json["id"],
        name: json["name"],
        shortName: json["shortName"],
        phone: json["phone"],
        crestUrl: json["crestUrl"],
        address: json["address"],
        website: json["website"],
        email: json["email"],
        clubColors: json["clubColors"],
        founded: json["founded"],
        venue: json["venue"],
      );
}
