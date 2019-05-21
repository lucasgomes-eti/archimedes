import 'dart:convert';

Vejo vejoFromJson(String str) => Vejo.fromJson(json.decode(str));

String vejoToJson(Vejo data) => json.encode(data.toJson());

class Vejo {
  int vejoId;
  int personaId;
  String vejo;

  Vejo({
    this.vejoId,
    this.personaId,
    this.vejo,
  });

  factory Vejo.fromJson(Map<String, dynamic> json) => new Vejo(
        vejoId: json["vejoId"],
        personaId: json["personaId"],
        vejo: json["vejo"],
      );

  Map<String, dynamic> toJson() => {
        "vejoId": vejoId,
        "personaId": personaId,
        "vejo": vejo,
      };
}
