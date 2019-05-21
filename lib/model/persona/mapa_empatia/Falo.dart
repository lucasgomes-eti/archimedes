import 'dart:convert';

Falo faloFromJson(String str) => Falo.fromJson(json.decode(str));

String faloToJson(Falo data) => json.encode(data.toJson());

class Falo {
  int faloId;
  int personaId;
  String falo;

  Falo({
    this.faloId,
    this.personaId,
    this.falo,
  });

  factory Falo.fromJson(Map<String, dynamic> json) => new Falo(
        faloId: json["faloId"],
        personaId: json["personaId"],
        falo: json["falo"],
      );

  Map<String, dynamic> toJson() => {
        "faloId": faloId,
        "personaId": personaId,
        "falo": falo,
      };
}
