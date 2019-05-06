import 'dart:async';

import 'package:archimedes/db/Database.dart';
import 'package:archimedes/model/VisaoProduto.dart';
import 'package:sqflite/sqflite.dart';

class VisaoProdutoDAO {
  var database = DBProvider.db.database;

  Future<int> create(VisaoProduto visaoProduto) async {
    return database.then((Database db) async {
      var res = await db.insert("visaoProduto", visaoProduto.toJson());
      return res;
    });
  }

  Future<VisaoProduto> read(int projetoId) async {
    return await database.then((Database db) async {
      var res = await db.query("visaoProduto",
          where: "projetoId = ?", whereArgs: [projetoId], limit: 1);
      List<VisaoProduto> list = res.isNotEmpty
          ? res.map((p) => VisaoProduto.fromJson(p)).toList()
          : [];
      return list.isNotEmpty ? list.first : null;
    });
  }

  Future<int> update(VisaoProduto newVisaoProduto) async {
    return database.then((Database db) async {
      var res = await db.update("visaoProduto", newVisaoProduto.toJson(),
          where: "visaoProdutoId = ? AND projetoId = ?",
          whereArgs: [
            newVisaoProduto.visaoProdutoId,
            newVisaoProduto.projetoId
          ]);
      return res;
    });
  }
}
