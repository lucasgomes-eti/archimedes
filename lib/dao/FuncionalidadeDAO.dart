import 'package:archimedes/db/Database.dart';
import 'package:archimedes/model/Funcionalidade.dart';
import 'package:sqflite/sqflite.dart';

class FuncionalidadeDAO {
  var database = DBProvider.db.database;

  Future<int> create(Funcionalidade funcionalidade) async {
    return database.then((Database db) async {
      var res = await db.insert("funcionalidade", funcionalidade.toJson());
      return res;
    });
  }

  Future<List<Funcionalidade>> readAll() async {
    return await database.then((Database db) async {
      var res = await db.query("funcionalidade");
      List<Funcionalidade> list = res.isNotEmpty
          ? res.map((p) => Funcionalidade.fromJson(p)).toList()
          : [];
      return list;
    });
  }

  Future<int> update(Funcionalidade newFuncionalidade) async {
    return database.then((Database db) async {
      var res = await db.update("funcionalidade", newFuncionalidade.toJson(),
          where: "funcionalidadeId = ?",
          whereArgs: [newFuncionalidade.funcionalidadeId]);
      return res;
    });
  }

  delete(int funcionalidadeId) async {
    await database.then((Database db) {
      db.delete("funcionalidade",
          where: "funcionalidadeId = ?", whereArgs: [funcionalidadeId]);
    });
  }
}
