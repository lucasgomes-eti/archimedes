import 'dart:async';
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
      await db.execute('''
      CREATE TABLE "projeto" (
      "projetoId" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      "nome" TEXT NOT NULL,
      "descricao" TEXT
      );
      ''');
      await db.execute('''
      CREATE TABLE "visaoProduto" (
      "visaoProdutoId" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      "projetoId" INTEGER NOT NULL,
      "cliente" TEXT,
      "problema" TEXT,
      "nome" TEXT,
      "categoria" TEXT,
      "beneficio" TEXT,
      "concorrencia" TEXT,
      "diferenca" TEXT,
      CONSTRAINT "fk_visaoProduto" FOREIGN KEY ("projetoId") REFERENCES "projeto" ("projetoId")
      );
      ''');
      await db.execute('''
      CREATE TABLE "produtoE" (
      "produtoEId" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      "projetoId" INTEGER,
      "produtoE" TEXT,
      CONSTRAINT "fk_produtoE" FOREIGN KEY ("projetoId") REFERENCES "projeto" ("projetoId")
      );
      ''');
      await db.execute('''
      CREATE TABLE "produtoNaoE" (
      "produtoNaoEId" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      "projetoId" INTEGER,
      "produtoNaoE" TEXT,
      CONSTRAINT "fk_produtoNaoE" FOREIGN KEY ("projetoId") REFERENCES "projeto" ("projetoId")
      );
      ''');
      await db.execute('''
      CREATE TABLE "produtoFaz" (
      "produtoFazId" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      "projetoId" INTEGER,
      "produtoFaz" TEXT,
      CONSTRAINT "fk_produtoFaz" FOREIGN KEY ("projetoId") REFERENCES "projeto" ("projetoId")
      );
      ''');
      await db.execute('''
      CREATE TABLE "produtoNaoFaz" (
      "produtoNaoFazId" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      "projetoId" INTEGER,
      "produtoNaoFaz" TEXT,
      CONSTRAINT "fk_produtoNaoFaz" FOREIGN KEY ("projetoId") REFERENCES "projeto" ("projetoId")
      );
      ''');
      await db.execute('''
      CREATE TABLE "objetivo" (
      "objetivoId" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      "projetoId" INTEGER,
      "objetivo" TEXT,
      CONSTRAINT "fk_objetivo" FOREIGN KEY ("projetoId") REFERENCES "projeto" ("projetoId")
      );
      ''');
      await db.execute('''
      CREATE TABLE "caracteristica" (
      "caracteristicaId" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      "projetoId" INTEGER,
      "caracteristica" TEXT,
      CONSTRAINT "fk_caracteristica" FOREIGN KEY ("projetoId") REFERENCES "projeto" ("projetoId")
      );
      ''');
      await db.execute('''
      CREATE TABLE "persona" (
      "personaId" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      "projetoId" INTEGER,
      "nome" TEXT,
      CONSTRAINT "fk_persona" FOREIGN KEY ("projetoId") REFERENCES "projeto" ("projetoId")
      );
      ''');
      await db.execute('''
      CREATE TABLE "jornada" (
      "jornadaId" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      "personaId" INTEGER,
      "jornada" TEXT,
      CONSTRAINT "fk_jornada" FOREIGN KEY ("personaId") REFERENCES "persona" ("personaId")
      );
      ''');
      await db.execute('''
      CREATE TABLE "penso" (
      "pensoId" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      "personaId" INTEGER,
      "penso" TEXT,
      CONSTRAINT "fk_penso" FOREIGN KEY ("personaId") REFERENCES "persona" ("personaId")
      );
      ''');
      await db.execute('''
      CREATE TABLE "ouco" (
      "oucoId" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      "personaId" INTEGER,
      "ouco" TEXT,
      CONSTRAINT "fk_ouco" FOREIGN KEY ("personaId") REFERENCES "persona" ("personaId")
      );
      ''');
      await db.execute('''
      CREATE TABLE "falo" (
      "faloId" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      "personaId" INTEGER,
      "falo" TEXT,
      CONSTRAINT "fk_falo" FOREIGN KEY ("personaId") REFERENCES "persona" ("personaId")
      );
      ''');
      await db.execute('''
      CREATE TABLE "vejo" (
      "vejoId" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      "personaId" INTEGER,
      "vejo" TEXT,
      CONSTRAINT "fk_vejo" FOREIGN KEY ("personaId") REFERENCES "persona" ("personaId")
      );
      ''');
      await db.execute('''
      CREATE TABLE "comportamento" (
      "comportamentoId" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      "personaId" INTEGER,
      "comportamento" TEXT,
      CONSTRAINT "fk_comportamento" FOREIGN KEY ("personaId") REFERENCES "persona" ("personaId")
      );
      ''');
      await db.execute('''
      CREATE TABLE "perfil" (
      "perfilId" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      "personaId" INTEGER,
      "perfil" TEXT,
      CONSTRAINT "fk_perfil" FOREIGN KEY ("personaId") REFERENCES "persona" ("personaId")
      );
      ''');
      await db.execute('''
      CREATE TABLE "necessidade" (
      "necessidadeId" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      "personaId" INTEGER,
      "necessidade" TEXT,
      CONSTRAINT "fk_necessidade" FOREIGN KEY ("personaId") REFERENCES "persona" ("personaId")
      );
      ''');
      await db.execute('''
      CREATE TABLE "funcionalidade" (
      "funcionalidadeId" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      "projetoId" INTEGER,
      "descricao" TEXT,
      "entendimentoNegocio" INTEGER,
      "certezaTecnica" INTEGER,
      "esforcoDesenvolvimento" INTEGER,
      "valorNegocio" INTEGER,
      "tempoDesenvolvimento" TEXT,
      CONSTRAINT "fk_funcionalidade" FOREIGN KEY ("projetoId") REFERENCES "projeto" ("projetoId")
      );
      ''');
    });
  }
}
