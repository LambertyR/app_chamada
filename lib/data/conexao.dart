import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'data_container.dart';

class Conexao {
  static Database? _database;

  static Future<Database> getConexaoDB() async {
    if (_database == null) {
      String databasesPath =
          join(await getDatabasesPath(), DATABASE_PRIMEIROAPP);

      _database = await openDatabase(databasesPath, version: 1,
          onCreate: (Database db, int version) async {
        await db.execute(CREATE_PERFIL_TABLE_SCRIPT);
        await db.execute(CREATE_DISCIPLINA_TABLE_SCRIPT);
        await db.execute(CREATE_ALUNO_TABLE_SCRIPT);
        await db.execute(CREATE_ALUNODISCIPLINA_TABLE_SCRIPT);
        await db.execute(CREATE_PRESENCA_TABLE_SCRIPT);

        await db.rawInsert('''insert into $PERFIL_TABLE_NAME(
              $PERFIL_COLUMN_NOME,
              $PERFIL_COLUMN_EMAIL,
              $PERFIL_COLUMN_SENHA)
              values(
                'admin','admin@admin','123') 
              ''');
      });
    }
    return _database!;
  }
}
