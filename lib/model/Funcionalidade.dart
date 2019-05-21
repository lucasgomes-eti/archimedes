import 'dart:convert';

Funcionalidade funcionalidadeFromJson(String str) => Funcionalidade.fromJson(json.decode(str));

String funcionalidadeToJson(Funcionalidade data) => json.encode(data.toJson());

class Funcionalidade {
    int funcionalidadeId;
    int projetoId;
    String descricao;
    Nivel entendimentoNegocio;
    Nivel certezaTecnica;
    Nivel esforcoDesenvolvimento;
    Nivel valorNegocio;
    String tempoDesenvolvimento;

    Funcionalidade({
        this.funcionalidadeId,
        this.projetoId,
        this.descricao,
        this.entendimentoNegocio,
        this.certezaTecnica,
        this.esforcoDesenvolvimento,
        this.valorNegocio,
        this.tempoDesenvolvimento,
    });

    factory Funcionalidade.fromJson(Map<String, dynamic> json) => new Funcionalidade(
        funcionalidadeId: json["funcionalidadeId"],
        projetoId: json["projetoId"],
        descricao: json["descricao"],
        entendimentoNegocio: json["entendimentoNegocio"],
        certezaTecnica: json["certezaTecnica"],
        esforcoDesenvolvimento: json["esforcoDesenvolvimento"],
        valorNegocio: json["valorNegocio"],
        tempoDesenvolvimento: json["tempoDesenvolvimento"],
    );

    Map<String, dynamic> toJson() => {
        "funcionalidadeId": funcionalidadeId,
        "projetoId": projetoId,
        "descricao": descricao,
        "entendimentoNegocio": entendimentoNegocio,
        "certezaTecnica": certezaTecnica,
        "esforcoDesenvolvimento": esforcoDesenvolvimento,
        "valorNegocio": valorNegocio,
        "tempoDesenvolvimento": tempoDesenvolvimento,
    };
}

enum Nivel { BAIXO, MEDIO, ALTO }