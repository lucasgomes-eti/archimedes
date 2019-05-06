import 'dart:async';

import 'package:archimedes/db/Database.dart';
import 'package:archimedes/model/produto_e_nao_e_faz_nao_faz/ProdutoE.dart';
import 'package:sqflite/sqflite.dart';

class ProdutoEDAO {
  var database = DBProvider.db.database;

  Future<int> create(ProdutoE produE) async {
    return database.then((Database db) async {
      var res = await db.insert("produtoE", produE.toJson());
      return res;
    });
  }

  Future<List<ProdutoE>> readAll() async {
    return await database.then((Database db) async {
      var res = await db.query("produtoE");
      List<ProdutoE> list =
          res.isNotEmpty ? res.map((p) => ProdutoE.fromJson(p)).toList() : [];
      return list;
    });
  }

  Future<int> update(ProdutoE newProduE) async {
    return database.then((Database db) async {
      var res = await db.update("produtoE", newProduE.toJson(),
          where: "produtoEId = ?", whereArgs: [newProduE.produtoEId]);
      return res;
    });
  }

  delete(int produtoEId) async {
    await database.then((Database db) {
      db.delete("produtoE", where: "produtoEId = ?", whereArgs: [produtoEId]);
    });
  }
}