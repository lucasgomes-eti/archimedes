import 'dart:convert';

Objetivo objetivoFromJson(String str) => Objetivo.fromJson(json.decode(str));

String objetivoToJson(Objetivo data) => json.encode(data.toJson());

class Objetivo {
    int objetivoId;
    int projetoId;
    String objetivo;

    Objetivo({
        this.objetivoId,
        this.projetoId,
        this.objetivo,
    });

    factory Objetivo.fromJson(Map<String, dynamic> json) => new Objetivo(
        objetivoId: json["objetivoId"],
        projetoId: json["projetoId"],
        objetivo: json["objetivo"],
    );

    Map<String, dynamic> toJson() => {
        "objetivoId": objetivoId,
        "projetoId": projetoId,
        "objetivo": objetivo,
    };
}