import 'package:archimedes/db/Database.dart';
import 'package:archimedes/model/Objetivo.dart';
import 'package:sqflite/sqflite.dart';

class ObjetivoDAO {
  var database = DBProvider.db.database;

  Future<int> create(Objetivo objetivo) async {
    return database.then((Database db) async {
      var res = await db.insert("objetivo", objetivo.toJson());
      return res;
    });
  }

  Future<List<Objetivo>> readAll() async {
    return await database.then((Database db) async {
      var res = await db.query("objetivo");
      List<Objetivo> list =
          res.isNotEmpty ? res.map((p) => Objetivo.fromJson(p)).toList() : [];
      return list;
    });
  }

  Future<int> update(Objetivo newObjetivo) async {
    return database.then((Database db) async {
      var res = await db.update("objetivo", newObjetivo.toJson(),
          where: "objetivoId = ?", whereArgs: [newObjetivo.objetivoId]);
      return res;
    });
  }

  delete(int objetivoId) async {
    await database.then((Database db) {
      db.delete("objetivo", where: "objetivoId = ?", whereArgs: [objetivoId]);
    });
  }
}