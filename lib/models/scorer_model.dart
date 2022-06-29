import 'dart:convert';

class Scorer {
  Scorer({
    required this.id,
    required this.name,
    required this.firstName,
    required this.dateOfBirth,
    required this.countryOfBirth,
    required this.nationality,
    required this.teamName,
    required this.numberOfGoals,
    required this.position,
  });

  int id;
  String name;
  String firstName;
  String dateOfBirth;
  String countryOfBirth;
  String nationality;
  String position;
  int? numberOfGoals;
  String? teamName;

  factory Scorer.fromJson(String str) => Scorer.fromMap(json.decode(str));

  factory Scorer.fromMap(Map<String, dynamic> json) => Scorer(
        id: json["id"],
        name: json["name"],
        firstName: json["firstName"],
        dateOfBirth: json["original_title"],
        countryOfBirth: json["overview"],
        nationality: json["popularity"],
        teamName: json["teamName"],
        position: json["poster_path"],
        numberOfGoals: json["numberOfGoals"],
      );
}
