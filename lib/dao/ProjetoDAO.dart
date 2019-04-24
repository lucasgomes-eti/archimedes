import 'package:archimedes/db/Database.dart';
import 'package:archimedes/model/Projeto.dart';
import 'package:sqflite/sqflite.dart';

class ProjetoDAO {
  var database = DBProvider.db.database;

  Future<int> create(Projeto projeto) async {
    return database.then((Database db) async {
      var res = await db.insert("projeto", projeto.toJson());
      return res;
    });
  }

  readAll() {}

  update(Projeto newProjeto) {}

  delete(int projetoId) {}
}
