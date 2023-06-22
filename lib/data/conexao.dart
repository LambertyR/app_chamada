import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'data_container.dart';

class Conexao {
  static Database? _database;

  static Future<Database> getConexaoDB() async {
    if (_database == null) {
      DateTime data = DateTime.now();
      String databasesPath =
          join(await getDatabasesPath(), DATABASE_PRIMEIROAPP);

      _database = await openDatabase(databasesPath, version: 1,
          onCreate: (Database db, int version) async {
        await db.execute(CREATE_PERFIL_TABLE_SCRIPT);
        await db.execute(CREATE_DISCIPLINA_TABLE_SCRIPT);
        await db.execute(CREATE_ALUNO_TABLE_SCRIPT);
        await db.execute(CREATE_ALUNODISCIPLINA_TABLE_SCRIPT);
        await db.execute(CREATE_PRESENCA_TABLE_SCRIPT);
        await db.execute(CREATE_INSTANCIA_TABLE_SCRIPT);

        await db.rawInsert('''insert into $PERFIL_TABLE_NAME(
              $PERFIL_COLUMN_NOME,
              $PERFIL_COLUMN_EMAIL,
              $PERFIL_COLUMN_SENHA)
              values(
                'admin','admin@admin','123') 
              ''');
        await db.rawInsert('''insert into $DISCIPLINA_TABLE_NAME(
              $DISCIPLINA_COLUMN_NOME,
              $DISCIPLINA_COLUMN_PERFIL_ID)
              values(
                'Matemática',1),
                ('Português', 1)
              ''');
        await db.rawInsert('''insert into $ALUNO_TABLE_NAME(
              $ALUNO_COLUMN_NOME, $ALUNO_COLUMN_REGISTRO)
              values(
                'João',123),
                ('Maria',124) ,
                ('Clebinho',125),
                ('Kami',126),
                ('Theodoro',127),
                ('Ana',128),
                ('Rafael',129)
              ''');
        await db.rawInsert('''insert into $ALUNODISCIPLINA_TABLE_NAME(
              $ALUNODISCIPLINA_COLUMN_ALUNO_ID, $ALUNODISCIPLINA_COLUMN_DISCIPLINA_ID)
              values(
                1,1),
                (2,1) ,
                (3,1),
                (4,1),
                (5,1),
                (6,1),
                (7,1),
                (1,2),
                (2,2)
              ''');
      });
    }
    return _database!;
  }
}
