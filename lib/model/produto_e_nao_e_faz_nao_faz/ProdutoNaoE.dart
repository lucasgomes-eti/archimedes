import 'dart:convert';

ProdutoNaoE produtoNaoEFromJson(String str) => ProdutoNaoE.fromJson(json.decode(str));

String produtoNaoEToJson(ProdutoNaoE data) => json.encode(data.toJson());

class ProdutoNaoE {
    int produtoNaoEId;
    int projetoId;
    String produtoNaoE;

    ProdutoNaoE({
        this.produtoNaoEId,
        this.projetoId,
        this.produtoNaoE,
    });

    factory ProdutoNaoE.fromJson(Map<String, dynamic> json) => new ProdutoNaoE(
        produtoNaoEId: json["produtoNaoEId"],
        projetoId: json["projetoId"],
        produtoNaoE: json["produtoNaoE"],
    );

    Map<String, dynamic> toJson() => {
        "produtoNaoEId": produtoNaoEId,
        "projetoId": projetoId,
        "produtoNaoE": produtoNaoE,
    };
}