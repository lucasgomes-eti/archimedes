import 'dart:convert';

Persona personaFromJson(String str) => Persona.fromJson(json.decode(str));

String personaToJson(Persona data) => json.encode(data.toJson());

class Persona {
    int personaId;
    int projetoId;
    String nome;

    Persona({
        this.personaId,
        this.projetoId,
        this.nome,
    });

    factory Persona.fromJson(Map<String, dynamic> json) => new Persona(
        personaId: json["personaId"],
        projetoId: json["projetoId"],
        nome: json["nome"],
    );

    Map<String, dynamic> toJson() => {
        "personaId": personaId,
        "projetoId": projetoId,
        "nome": nome,
    };
}