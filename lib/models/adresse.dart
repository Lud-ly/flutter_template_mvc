class Adress{
  String addr1;
  String addr2;
  String cp;
  String ville;

  Adress({required this.addr1, required this.addr2, required this.cp, required this.ville});

  factory Adress.fromMap(Map<String, dynamic> data){
    return Adress(addr1: data["addr1"], addr2: data["addr2"], cp: data["cp"], ville: data["ville"]);
  }

  Map<String, dynamic> toMap(){
    return {
      "addr1" : addr1,
      "addr2" : addr2,
      "cp" : cp,
      "ville" : ville,
    };
  }
}