import 'dart:async';

import 'package:archimedes/db/Database.dart';
import 'package:archimedes/model/persona/Persona.dart';
import 'package:sqflite/sqflite.dart';

class PersonaDAO {
  var database = DBProvider.db.database;

  Future<int> create(Persona persona) async {
    return database.then((Database db) async {
      var res = await db.insert("persona", persona.toJson());
      return res;
    });
  }

  Future<List<Persona>> readAll() async {
    return await database.then((Database db) async {
      var res = await db.query("persona");
      List<Persona> list =
          res.isNotEmpty ? res.map((p) => Persona.fromJson(p)).toList() : [];
      return list;
    });
  }

  Future<int> update(Persona newPersona) async {
    return database.then((Database db) async {
      var res = await db.update("persona", newPersona.toJson(),
          where: "personaId = ?", whereArgs: [newPersona.personaId]);
      return res;
    });
  }

  delete(int personaId) async {
    await database.then((Database db) {
      db.delete("persona", where: "personaId = ?", whereArgs: [personaId]);
    });
  }
}