import 'dart:convert';

Ouco oucoFromJson(String str) => Ouco.fromJson(json.decode(str));

String oucoToJson(Ouco data) => json.encode(data.toJson());

class Ouco {
  int oucoId;
  int personaId;
  String ouco;

  Ouco({
    this.oucoId,
    this.personaId,
    this.ouco,
  });

  factory Ouco.fromJson(Map<String, dynamic> json) => new Ouco(
        oucoId: json["oucoId"],
        personaId: json["personaId"],
        ouco: json["ouco"],
      );

  Map<String, dynamic> toJson() => {
        "oucoId": oucoId,
        "personaId": personaId,
        "ouco": ouco,
      };
}
