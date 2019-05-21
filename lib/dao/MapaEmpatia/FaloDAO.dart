import 'package:archimedes/db/Database.dart';
import 'package:archimedes/model/persona/mapa_empatia/Falo.dart';
import 'package:sqflite/sqflite.dart';

class FaloDAO {
  var database = DBProvider.db.database;

  Future<int> create(Falo falo) async {
    return database.then((Database db) async {
      var res = await db.insert("falo", falo.toJson());
      return res;
    });
  }

  Future<List<Falo>> readAll() async {
    return await database.then((Database db) async {
      var res = await db.query("falo");
      List<Falo> list =
          res.isNotEmpty ? res.map((p) => Falo.fromJson(p)).toList() : [];
      return list;
    });
  }

  Future<int> update(Falo newFalo) async {
    return database.then((Database db) async {
      var res = await db.update("falo", newFalo.toJson(),
          where: "faloId = ?", whereArgs: [newFalo.faloId]);
      return res;
    });
  }

  delete(int faloId) async {
    await database.then((Database db) {
      db.delete("falo", where: "faloId = ?", whereArgs: [faloId]);
    });
  }
}
