import 'dart:async';

import 'package:archimedes/db/Database.dart';
import 'package:archimedes/model/produto_e_nao_e_faz_nao_faz/ProdutoFaz.dart';
import 'package:sqflite/sqflite.dart';

class ProdutoFazDAO {
  var database = DBProvider.db.database;

  Future<int> create(ProdutoFaz produtoFaz) async {
    return database.then((Database db) async {
      var res = await db.insert("produtoFaz", produtoFaz.toJson());
      return res;
    });
  }

  Future<List<ProdutoFaz>> readAll() async {
    return await database.then((Database db) async {
      var res = await db.query("produtoFaz");
      List<ProdutoFaz> list =
          res.isNotEmpty ? res.map((p) => ProdutoFaz.fromJson(p)).toList() : [];
      return list;
    });
  }

  Future<int> update(ProdutoFaz newProdutoFaz) async {
    return database.then((Database db) async {
      var res = await db.update("produtoFaz", newProdutoFaz.toJson(),
          where: "produtoFazId = ?", whereArgs: [newProdutoFaz.produtoFazId]);
      return res;
    });
  }

  delete(int produtoFazId) async {
    await database.then((Database db) {
      db.delete("produtoFaz",
          where: "produtoFazId = ?", whereArgs: [produtoFazId]);
    });
  }
}
