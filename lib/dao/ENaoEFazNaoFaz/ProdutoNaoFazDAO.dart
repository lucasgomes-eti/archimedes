import 'dart:async';

import 'package:archimedes/db/Database.dart';
import 'package:archimedes/model/produto_e_nao_e_faz_nao_faz/ProdutoNaoFaz.dart';
import 'package:sqflite/sqflite.dart';

class ProdutoNaoFazDAO {
  var database = DBProvider.db.database;

  Future<int> create(ProdutoNaoFaz projeto) async {
    return database.then((Database db) async {
      var res = await db.insert("produtoNaoFaz", projeto.toJson());
      return res;
    });
  }

  Future<List<ProdutoNaoFaz>> readAll() async {
    return await database.then((Database db) async {
      var res = await db.query("produtoNaoFaz");
      List<ProdutoNaoFaz> list = res.isNotEmpty
          ? res.map((p) => ProdutoNaoFaz.fromJson(p)).toList()
          : [];
      return list;
    });
  }

  Future<int> update(ProdutoNaoFaz newProjeto) async {
    return database.then((Database db) async {
      var res = await db.update("produtoNaoFaz", newProjeto.toJson(),
          where: "produtoNaoFazId = ?",
          whereArgs: [newProjeto.produtoNaoFazId]);
      return res;
    });
  }

  delete(int produtoNaoFazId) async {
    await database.then((Database db) {
      db.delete("produtoNaoFaz",
          where: "produtoNaoFazId = ?", whereArgs: [produtoNaoFazId]);
    });
  }
}
