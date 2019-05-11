import 'dart:convert';

Caracteristica caracteristicaFromJson(String str) => Caracteristica.fromJson(json.decode(str));

String caracteristicaToJson(Caracteristica data) => json.encode(data.toJson());

class Caracteristica {
    int caracteristicaId;
    int projetoId;
    String caracteristica;

    Caracteristica({
        this.caracteristicaId,
        this.projetoId,
        this.caracteristica,
    });

    factory Caracteristica.fromJson(Map<String, dynamic> json) => new Caracteristica(
        caracteristicaId: json["caracteristicaId"],
        projetoId: json["projetoId"],
        caracteristica: json["caracteristica"],
    );

    Map<String, dynamic> toJson() => {
        "caracteristicaId": caracteristicaId,
        "projetoId": projetoId,
        "caracteristica": caracteristica,
    };
}