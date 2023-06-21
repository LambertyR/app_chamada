import 'package:chamada_univel/data/instancia_entity.dart';
import 'package:chamada_univel/data/instancia_sqlite_datasource.dart';
import 'package:chamada_univel/data/perfil_entity.dart';
import 'package:chamada_univel/data/perfil_sqlite_datasource.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'disciplina_entity.dart';
import 'conexao.dart';
import 'data_container.dart';

class DisciplinaSQLiteDataSource {
  Future create(DisciplinaEntity disciplina) async {
    print("* * * * * * * * CREATE DISCIPLINA * * * * * * * *");
    try {
      final Database db = await Conexao.getConexaoDB();
      disciplina.disciplinaID =
          await db.rawInsert('''insert into $DISCIPLINA_TABLE_NAME(
        $DISCIPLINA_COLUMN_NOME,
        $DISCIPLINA_COLUMN_PERFIL_ID)
        values(
          '${disciplina.nome}', '${disciplina.perfil?.perfilID}'
      )''');
      queryAllRows();
      return true;
    } catch (ex) {
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await Conexao.getConexaoDB();
    return await db.query(DISCIPLINA_TABLE_NAME);
  }

  Future<List<DisciplinaEntity>> getAllDisciplina() async {
    print("* * * * * * * * GET ALL DISCIPLINA * * * * * * * *");
    Database db = await Conexao.getConexaoDB();
    PerfilEntity? perfil = new PerfilEntity();
    perfil = await PerfilSQLiteDataSource().buscarPerfil() as PerfilEntity?;
    List<Map> dnResult = await db.rawQuery(
        'SELECT * FROM $DISCIPLINA_TABLE_NAME where $DISCIPLINA_COLUMN_PERFIL_ID = ?',
        [perfil?.perfilID]);

    List<DisciplinaEntity> disciplinas = [];
    for (var row in dnResult) {
      DisciplinaEntity disciplina = DisciplinaEntity();
      disciplina.disciplinaID = row['$DISCIPLINA_COLUMN_ID'];
      disciplina.nome = row['$DISCIPLINA_COLUMN_NOME'];
      disciplina.perfil?.perfilID = row['$DISCIPLINA_COLUMN_PERFIL_ID'];

      disciplinas.add(disciplina);
    }
    return disciplinas;
  }

  Future<void> atualizarDisciplina(DisciplinaEntity disciplina) async {
    print("* * * * * * * * ATUALIZAR DISCIPLINA * * * * * * * *");
    Database db = await Conexao.getConexaoDB();
    await db.transaction((txn) async {
      await txn.rawUpdate(
          'update $DISCIPLINA_TABLE_NAME set $DISCIPLINA_COLUMN_NOME = ?, $DISCIPLINA_COLUMN_PERFIL_ID = ?, where id = ?',
          [
            disciplina.nome,
            disciplina.perfil?.perfilID,
            disciplina.disciplinaID,
          ]);
    });
  }

  Future<void> deletarDisciplina(int disciplinaID) async {
    print("* * * * * * * * DELETAR DISCIPLINA * * * * * * * *");
    Database db = await Conexao.getConexaoDB();
    await db.transaction((txn) async {
      await txn.rawUpdate(
          'DELETE FROM $DISCIPLINA_TABLE_NAME WHERE $DISCIPLINA_COLUMN_ID = ?',
          ['$disciplinaID']);
    });
  }

  // Future<List<DisciplinaEntity>> pesquisarSenha(String filtro) async {
  //   print("* * * * * * * * GET ALL DISCIPLINA * * * * * * * *");
  //   List<DisciplinaEntity> disciplinas = [];
  //   Database db = await Conexao.getConexaoDB();
  //   List<Map> dbResult = await db.rawQuery(
  //       'SELECT * FROM $DISCIPLINA_TABLE_NAME WHERE $DISCIPLINA_COLUMN_NOME LIKE ?',
  //       ['%$filtro%']);
  //   for (var row in dbResult) {
  //     DisciplinaEntity disciplina = DisciplinaEntity();
  //     disciplina.disciplinaID = row['disciplinaID'];
  //     disciplina.nome = row['nome'];
  //     disciplina.perfil?.perfilID = row['professor_id'];
  //     disciplinas.add(disciplina);
  //   }
  //   return disciplinas;
  // }

  Future<void> deletarDisciplinas() async {
    print("* * * * * * * * DELETAR DISCIPLINAS * * * * * * * *");
    Database db = await Conexao.getConexaoDB();
    await db.transaction((txn) async {
      await txn.rawDelete('delete from $DISCIPLINA_TABLE_NAME');
    });
  }
}
