import 'dart:convert';

class VisaoProduto {
  int visaoProdutoId;
  int projetoId;
  String cliente;
  String problema;
  String nome;
  String categoria;
  String beneficio;
  String concorrencia;
  String diferenca;

  VisaoProduto(
      {this.visaoProdutoId,
      this.projetoId,
      this.cliente,
      this.problema,
      this.nome,
      this.categoria,
      this.beneficio,
      this.concorrencia,
      this.diferenca});

  factory VisaoProduto.fromJson(Map<String, dynamic> json) => VisaoProduto(
        visaoProdutoId: json['visaoProdutoId'],
        projetoId: json['projetoId'],
        cliente: json['cliente'],
        problema: json['problema'],
        nome: json['nome'],
        categoria: json['categoria'],
        beneficio: json['beneficio'],
        concorrencia: json['concorrencia'],
        diferenca: json['diferenca'],
      );

  Map<String, dynamic> toJson() => {
        "visaoProdutoId": visaoProdutoId,
        "projetoId": projetoId,
        "cliente": cliente,
        "problema": problema,
        "nome": nome,
        "categoria": categoria,
        "beneficio": beneficio,
        "concorrencia": concorrencia,
        "diferenca": diferenca,
      };
}

VisaoProduto visaoProdutofromJson(String str) =>
    VisaoProduto.fromJson(json.decode(str));

String visaoProdutoToJson(VisaoProduto data) => json.encode(data.toJson());
