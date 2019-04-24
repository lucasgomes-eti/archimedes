import 'dart:convert';

class Projeto {
  int projetoId;
  String nome;
  String descricao;

  Projeto({this.projetoId, this.nome, this.descricao});

  factory Projeto.fromJson(Map<String, dynamic> json) => Projeto(
      projetoId: json['projetoId'],
      nome: json['nome'],
      descricao: json['descricao']);

  Map<String, dynamic> toJson() =>
      {"projetoId": projetoId, "nome": nome, "descricao": descricao};
}

Projeto projetoFromJson(String str) => Projeto.fromJson(json.decode(str));

String projetoToJson(Projeto data) => json.encode(data.toJson());