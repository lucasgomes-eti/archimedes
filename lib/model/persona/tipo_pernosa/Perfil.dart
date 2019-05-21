import 'dart:convert';

Perfil perfilFromJson(String str) => Perfil.fromJson(json.decode(str));

String perfilToJson(Perfil data) => json.encode(data.toJson());

class Perfil {
  int perfilId;
  int personaId;
  String perfil;

  Perfil({
    this.perfilId,
    this.personaId,
    this.perfil,
  });

  factory Perfil.fromJson(Map<String, dynamic> json) => new Perfil(
        perfilId: json["perfilId"],
        personaId: json["personaId"],
        perfil: json["perfil"],
      );

  Map<String, dynamic> toJson() => {
        "perfilId": perfilId,
        "personaId": personaId,
        "perfil": perfil,
      };
}