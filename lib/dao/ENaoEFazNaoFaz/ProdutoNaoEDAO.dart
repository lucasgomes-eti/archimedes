import 'dart:async';

import 'package:archimedes/db/Database.dart';
import 'package:archimedes/model/produto_e_nao_e_faz_nao_faz/ProdutoNaoE.dart';
import 'package:sqflite/sqflite.dart';

class ProdutoNaoEDAO {
  var database = DBProvider.db.database;

  Future<int> create(ProdutoNaoE produtoNaoE) async {
    return database.then((Database db) async {
      var res = await db.insert("produtoNaoE", produtoNaoE.toJson());
      return res;
    });
  }

  Future<List<ProdutoNaoE>> readAll() async {
    return await database.then((Database db) async {
      var res = await db.query("produtoNaoE");
      List<ProdutoNaoE> list = res.isNotEmpty
          ? res.map((p) => ProdutoNaoE.fromJson(p)).toList()
          : [];
      return list;
    });
  }

  Future<int> update(ProdutoNaoE newProdutoNaoE) async {
    return database.then((Database db) async {
      var res = await db.update("produtoNaoE", newProdutoNaoE.toJson(),
          where: "produtoNaoEId = ?",
          whereArgs: [newProdutoNaoE.produtoNaoEId]);
      return res;
    });
  }

  delete(int produtoNaoEId) async {
    await database.then((Database db) {
      db.delete("produtoNaoE",
          where: "produtoNaoEId = ?", whereArgs: [produtoNaoEId]);
    });
  }
}
