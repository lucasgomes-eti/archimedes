import 'package:archimedes/db/Database.dart';
import 'package:archimedes/model/persona/mapa_empatia/Penso.dart';
import 'package:sqflite/sqflite.dart';

class PensoDAO {
  var database = DBProvider.db.database;

  Future<int> create(Penso penso) async {
    return database.then((Database db) async {
      var res = await db.insert("penso", penso.toJson());
      return res;
    });
  }

  Future<List<Penso>> readAll() async {
    return await database.then((Database db) async {
      var res = await db.query("penso");
      List<Penso> list =
          res.isNotEmpty ? res.map((p) => Penso.fromJson(p)).toList() : [];
      return list;
    });
  }

  Future<int> update(Penso newPenso) async {
    return database.then((Database db) async {
      var res = await db.update("penso", newPenso.toJson(),
          where: "pensoId = ?", whereArgs: [newPenso.pensoId]);
      return res;
    });
  }

  delete(int pensoId) async {
    await database.then((Database db) {
      db.delete("penso", where: "pensoId = ?", whereArgs: [pensoId]);
    });
  }
}
