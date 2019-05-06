import 'dart:convert';

ProdutoE produtoEFromJson(String str) => ProdutoE.fromJson(json.decode(str));

String produtoEToJson(ProdutoE data) => json.encode(data.toJson());

class ProdutoE {
    int produtoEId;
    int projetoId;
    String produtoE;

    ProdutoE({
        this.produtoEId,
        this.projetoId,
        this.produtoE,
    });

    factory ProdutoE.fromJson(Map<String, dynamic> json) => new ProdutoE(
        produtoEId: json["produtoEId"],
        projetoId: json["projetoId"],
        produtoE: json["produtoE"],
    );

    Map<String, dynamic> toJson() => {
        "produtoEId": produtoEId,
        "projetoId": projetoId,
        "produtoE": produtoE,
    };
}