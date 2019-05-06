import 'dart:convert';

ProdutoFaz produtoFazFromJson(String str) => ProdutoFaz.fromJson(json.decode(str));

String produtoFazToJson(ProdutoFaz data) => json.encode(data.toJson());

class ProdutoFaz {
    int produtoFazId;
    int projetoId;
    String produtoFaz;

    ProdutoFaz({
        this.produtoFazId,
        this.projetoId,
        this.produtoFaz,
    });

    factory ProdutoFaz.fromJson(Map<String, dynamic> json) => new ProdutoFaz(
        produtoFazId: json["produtoFazId"],
        projetoId: json["projetoId"],
        produtoFaz: json["produtoFaz"],
    );

    Map<String, dynamic> toJson() => {
        "produtoFazId": produtoFazId,
        "projetoId": projetoId,
        "produtoFaz": produtoFaz,
    };
}