import 'package:archimedes/db/Database.dart';
import 'package:archimedes/model/Jornada.dart';
import 'package:sqflite/sqflite.dart';

class JornadaDAO {
  var database = DBProvider.db.database;

  Future<int> create(Jornada jornada) async {
    return database.then((Database db) async {
      var res = await db.insert("jornada", jornada.toJson());
      return res;
    });
  }

  Future<List<Jornada>> readAll() async {
    return await database.then((Database db) async {
      var res = await db.query("jornada");
      List<Jornada> list =
          res.isNotEmpty ? res.map((p) => Jornada.fromJson(p)).toList() : [];
      return list;
    });
  }

  Future<int> update(Jornada newJornada) async {
    return database.then((Database db) async {
      var res = await db.update("jornada", newJornada.toJson(),
          where: "jornadaId = ?", whereArgs: [newJornada.jornadaId]);
      return res;
    });
  }

  delete(int jornadaId) async {
    await database.then((Database db) {
      db.delete("jornada", where: "jornadaId = ?", whereArgs: [jornadaId]);
    });
  }
}
