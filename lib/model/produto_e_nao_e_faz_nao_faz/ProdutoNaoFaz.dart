import 'dart:convert';

ProdutoNaoFaz produtoNaoFazFromJson(String str) => ProdutoNaoFaz.fromJson(json.decode(str));

String produtoNaoFazToJson(ProdutoNaoFaz data) => json.encode(data.toJson());

class ProdutoNaoFaz {
    int produtoNaoFazId;
    int projetoId;
    String produtoNaoFaz;

    ProdutoNaoFaz({
        this.produtoNaoFazId,
        this.projetoId,
        this.produtoNaoFaz,
    });

    factory ProdutoNaoFaz.fromJson(Map<String, dynamic> json) => new ProdutoNaoFaz(
        produtoNaoFazId: json["produtoNaoFazId"],
        projetoId: json["projetoId"],
        produtoNaoFaz: json["produtoNaoFaz"],
    );

    Map<String, dynamic> toJson() => {
        "produtoNaoFazId": produtoNaoFazId,
        "projetoId": projetoId,
        "produtoNaoFaz": produtoNaoFaz,
    };
}