import 'package:archimedes/db/Database.dart';
import 'package:archimedes/model/persona/tipo_pernosa/Comportamento.dart';
import 'package:sqflite/sqflite.dart';

class ComportamentoDAO {
  var database = DBProvider.db.database;

  Future<int> create(Comportamento comportamento) async {
    return database.then((Database db) async {
      var res = await db.insert("comportamento", comportamento.toJson());
      return res;
    });
  }

  Future<List<Comportamento>> readAll() async {
    return await database.then((Database db) async {
      var res = await db.query("comportamento");
      List<Comportamento> list = res.isNotEmpty
          ? res.map((p) => Comportamento.fromJson(p)).toList()
          : [];
      return list;
    });
  }

  Future<int> update(Comportamento newComportamento) async {
    return database.then((Database db) async {
      var res = await db.update("comportamento", newComportamento.toJson(),
          where: "comportamentoId = ?",
          whereArgs: [newComportamento.comportamentoId]);
      return res;
    });
  }

  delete(int comportamentoId) async {
    await database.then((Database db) {
      db.delete("comportamento",
          where: "comportamentoId = ?", whereArgs: [comportamentoId]);
    });
  }
}
