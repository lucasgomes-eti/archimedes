import 'package:archimedes/db/Database.dart';
import 'package:archimedes/model/persona/mapa_empatia/Ouco.dart';
import 'package:sqflite/sqflite.dart';

class OucoDAO {
  var database = DBProvider.db.database;

  Future<int> create(Ouco ouco) async {
    return database.then((Database db) async {
      var res = await db.insert("ouco", ouco.toJson());
      return res;
    });
  }

  Future<List<Ouco>> readAll() async {
    return await database.then((Database db) async {
      var res = await db.query("ouco");
      List<Ouco> list =
          res.isNotEmpty ? res.map((p) => Ouco.fromJson(p)).toList() : [];
      return list;
    });
  }

  Future<int> update(Ouco newOuco) async {
    return database.then((Database db) async {
      var res = await db.update("ouco", newOuco.toJson(),
          where: "oucoId = ?", whereArgs: [newOuco.oucoId]);
      return res;
    });
  }

  delete(int oucoId) async {
    await database.then((Database db) {
      db.delete("ouco", where: "oucoId = ?", whereArgs: [oucoId]);
    });
  }
}
