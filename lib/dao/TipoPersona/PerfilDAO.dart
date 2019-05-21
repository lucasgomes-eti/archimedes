import 'package:archimedes/db/Database.dart';
import 'package:archimedes/model/persona/tipo_pernosa/Perfil.dart';
import 'package:sqflite/sqflite.dart';

class PerfilDAO {
  var database = DBProvider.db.database;

  Future<int> create(Perfil perfil) async {
    return database.then((Database db) async {
      var res = await db.insert("perfil", perfil.toJson());
      return res;
    });
  }

  Future<List<Perfil>> readAll() async {
    return await database.then((Database db) async {
      var res = await db.query("perfil");
      List<Perfil> list =
          res.isNotEmpty ? res.map((p) => Perfil.fromJson(p)).toList() : [];
      return list;
    });
  }

  Future<int> update(Perfil newPerfil) async {
    return database.then((Database db) async {
      var res = await db.update("perfil", newPerfil.toJson(),
          where: "perfilId = ?", whereArgs: [newPerfil.perfilId]);
      return res;
    });
  }

  delete(int perfilId) async {
    await database.then((Database db) {
      db.delete("perfil", where: "perfilId = ?", whereArgs: [perfilId]);
    });
  }
}
