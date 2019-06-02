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
        entendimentoNegocio: valueToNivel(json["entendimentoNegocio"]),
        certezaTecnica: valueToNivel(json["certezaTecnica"]),
        esforcoDesenvolvimento: valueToNivel(json["esforcoDesenvolvimento"]),
        valorNegocio: valueToNivel(json["valorNegocio"]),
        tempoDesenvolvimento: json["tempoDesenvolvimento"],
    );

    Map<String, dynamic> toJson() => {
        "funcionalidadeId": funcionalidadeId,
        "projetoId": projetoId,
        "descricao": descricao,
        "entendimentoNegocio": nivelToValue(entendimentoNegocio),
        "certezaTecnica": nivelToValue(certezaTecnica),
        "esforcoDesenvolvimento": nivelToValue(esforcoDesenvolvimento),
        "valorNegocio": nivelToValue(valorNegocio),
        "tempoDesenvolvimento": tempoDesenvolvimento,
    };
}

Nivel valueToNivel(int value) {
    switch (value) {
      case 0:
        return Nivel.BAIXO;
        break;
      case 1:
        return Nivel.MEDIO;
        break;
      case 2:
        return Nivel.ALTO;
        break;
      default:
        return Nivel.BAIXO;
        break;
    }
  }

  int nivelToValue(Nivel nivel) {
    switch (nivel) {
      case Nivel.BAIXO:
        return 0;
        break;
      case Nivel.MEDIO:
        return 1;
        break;
      case Nivel.ALTO:
        return 2;
        break;
      default:
        return 0;
        break;
    }
  }

enum Nivel { BAIXO, MEDIO, ALTO }