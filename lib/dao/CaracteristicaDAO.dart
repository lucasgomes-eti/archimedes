import 'package:archimedes/db/Database.dart';
import 'package:archimedes/model/Caracteristica.dart';
import 'package:sqflite/sqflite.dart';

class CaracteristicaDAO {
  var database = DBProvider.db.database;

  Future<int> create(Caracteristica caracteristica) async {
    return database.then((Database db) async {
      var res = await db.insert("caracteristica", caracteristica.toJson());
      return res;
    });
  }

  Future<List<Caracteristica>> readAll() async {
    return await database.then((Database db) async {
      var res = await db.query("caracteristica");
      List<Caracteristica> list = res.isNotEmpty
          ? res.map((p) => Caracteristica.fromJson(p)).toList()
          : [];
      return list;
    });
  }

  Future<int> update(Caracteristica newCaracteristica) async {
    return database.then((Database db) async {
      var res = await db.update("caracteristica", newCaracteristica.toJson(),
          where: "caracteristicaId = ?",
          whereArgs: [newCaracteristica.caracteristicaId]);
      return res;
    });
  }

  delete(int caracteristicaId) async {
    await database.then((Database db) {
      db.delete("caracteristica",
          where: "caracteristicaId = ?", whereArgs: [caracteristicaId]);
    });
  }
}
