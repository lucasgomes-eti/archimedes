import 'dart:async';

import 'package:archimedes/db/Database.dart';
import 'package:archimedes/model/Projeto.dart';
import 'package:sqflite/sqflite.dart';

class ProjetoDAO {
  var database = DBProvider.db.database;

  Future<int> create(Projeto projeto) async {
    return database.then((Database db) async {
      var res = await db.insert("projeto", projeto.toJson());
      return res;
    });
  }

  Future<List<Projeto>> readAll() async {
    return await database.then((Database db) async {
      var res = await db.query("projeto");
      List<Projeto> list =
          res.isNotEmpty ? res.map((p) => Projeto.fromJson(p)).toList() : [];
      return list;
    });
  }

  Future<int> update(Projeto newProjeto) async {
    return database.then((Database db) async {
      var res = await db.update("projeto", newProjeto.toJson(),
          where: "projetoId = ?", whereArgs: [newProjeto.projetoId]);
      return res;
    });
  }

  delete(int projetoId) async {
    await database.then((Database db) {
      db.delete("projeto", where: "projetoId = ?", whereArgs: [projetoId]);
    });
  }
}