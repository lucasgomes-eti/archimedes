import 'package:archimedes/db/Database.dart';
import 'package:archimedes/model/persona/tipo_pernosa/Necessidade.dart';
import 'package:sqflite/sqflite.dart';

class NecessidadeDAO {
  var database = DBProvider.db.database;

  Future<int> create(Necessidade necessidade) async {
    return database.then((Database db) async {
      var res = await db.insert("necessidade", necessidade.toJson());
      return res;
    });
  }

  Future<List<Necessidade>> readAll() async {
    return await database.then((Database db) async {
      var res = await db.query("necessidade");
      List<Necessidade> list = res.isNotEmpty
          ? res.map((p) => Necessidade.fromJson(p)).toList()
          : [];
      return list;
    });
  }

  Future<int> update(Necessidade newNecessidade) async {
    return database.then((Database db) async {
      var res = await db.update("necessidade", newNecessidade.toJson(),
          where: "necessidadeId = ?",
          whereArgs: [newNecessidade.necessidadeId]);
      return res;
    });
  }

  delete(int necessidadeId) async {
    await database.then((Database db) {
      db.delete("necessidade",
          where: "necessidadeId = ?", whereArgs: [necessidadeId]);
    });
  }
}
