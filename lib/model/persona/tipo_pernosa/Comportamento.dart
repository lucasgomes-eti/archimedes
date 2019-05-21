import 'dart:convert';

Comportamento comportamentoFromJson(String str) =>
    Comportamento.fromJson(json.decode(str));

String comportamentoToJson(Comportamento data) => json.encode(data.toJson());

class Comportamento {
  int comportamentoId;
  int personaId;
  String comportamento;

  Comportamento({
    this.comportamentoId,
    this.personaId,
    this.comportamento,
  });

  factory Comportamento.fromJson(Map<String, dynamic> json) =>
      new Comportamento(
        comportamentoId: json["comportamentoId"],
        personaId: json["personaId"],
        comportamento: json["comportamento"],
      );

  Map<String, dynamic> toJson() => {
        "comportamentoId": comportamentoId,
        "personaId": personaId,
        "comportamento": comportamento,
      };
}