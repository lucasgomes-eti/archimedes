import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "archimedes.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
        "CREATE TABLE \"projeto\" (" +
        "\"projetoId\" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL," +
        "\"nome\" TEXT NOT NULL," +
        "\"descricao\" TEXT" +
        ");"
        );
    });
  }
}
