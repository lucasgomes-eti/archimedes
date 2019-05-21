import 'dart:convert';

Necessidade necessidadeFromJson(String str) =>
    Necessidade.fromJson(json.decode(str));

String necessidadeToJson(Necessidade data) => json.encode(data.toJson());

class Necessidade {
  int necessidadeId;
  int personaId;
  String necessidade;

  Necessidade({
    this.necessidadeId,
    this.personaId,
    this.necessidade,
  });

  factory Necessidade.fromJson(Map<String, dynamic> json) => new Necessidade(
        necessidadeId: json["necessidadeId"],
        personaId: json["personaId"],
        necessidade: json["necessidade"],
      );

  Map<String, dynamic> toJson() => {
        "necessidadeId": necessidadeId,
        "personaId": personaId,
        "necessidade": necessidade,
      };
}