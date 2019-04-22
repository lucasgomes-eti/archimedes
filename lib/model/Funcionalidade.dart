class Funcionalidade {
  int funcionalidadeId;
  int projetoId;
  String descricao;
  Nivel entendimentoNegocio;
  Nivel certezaTecnica;
  Nivel esforcoDesenvolvimento;
  Nivel valorNegocio;
  String tempoDesenvolvimento;
}

enum Nivel { BAIXO, MEDIO, ALTO }