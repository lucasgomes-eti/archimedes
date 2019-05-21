import 'dart:convert';

Penso pensoFromJson(String str) => Penso.fromJson(json.decode(str));

String pensoToJson(Penso data) => json.encode(data.toJson());

class Penso {
  int pensoId;
  int personaId;
  String penso;

  Penso({
    this.pensoId,
    this.personaId,
    this.penso,
  });

  factory Penso.fromJson(Map<String, dynamic> json) => new Penso(
        pensoId: json["pensoId"],
        personaId: json["personaId"],
        penso: json["penso"],
      );

  Map<String, dynamic> toJson() => {
        "pensoId": pensoId,
        "personaId": personaId,
        "penso": penso,
      };
}
