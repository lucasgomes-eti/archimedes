import 'package:archimedes/db/Database.dart';
import 'package:archimedes/model/persona/mapa_empatia/Vejo.dart';
import 'package:sqflite/sqflite.dart';

class VejoDAO {
  var database = DBProvider.db.database;

  Future<int> create(Vejo vejo) async {
    return database.then((Database db) async {
      var res = await db.insert("vejo", vejo.toJson());
      return res;
    });
  }

  Future<List<Vejo>> readAll() async {
    return await database.then((Database db) async {
      var res = await db.query("vejo");
      List<Vejo> list =
          res.isNotEmpty ? res.map((p) => Vejo.fromJson(p)).toList() : [];
      return list;
    });
  }

  Future<int> update(Vejo newVejo) async {
    return database.then((Database db) async {
      var res = await db.update("vejo", newVejo.toJson(),
          where: "vejoId = ?", whereArgs: [newVejo.vejoId]);
      return res;
    });
  }

  delete(int vejoId) async {
    await database.then((Database db) {
      db.delete("vejo", where: "vejoId = ?", whereArgs: [vejoId]);
    });
  }
}
