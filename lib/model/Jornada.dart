import 'dart:convert';

Jornada jornadaFromJson(String str) => Jornada.fromJson(json.decode(str));

String jornadaToJson(Jornada data) => json.encode(data.toJson());

class Jornada {
  int jornadaId;
  int personaId;
  String jornada;

  Jornada({
    this.jornadaId,
    this.personaId,
    this.jornada,
  });

  factory Jornada.fromJson(Map<String, dynamic> json) => new Jornada(
        jornadaId: json["jornadaId"],
        personaId: json["personaId"],
        jornada: json["jornada"],
      );

  Map<String, dynamic> toJson() => {
        "jornadaId": jornadaId,
        "personaId": personaId,
        "jornada": jornada,
      };
}
