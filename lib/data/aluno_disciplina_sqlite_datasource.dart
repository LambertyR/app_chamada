import 'package:chamada_univel/data/aluno_entity.dart';
import 'package:chamada_univel/data/disciplina_entity.dart';
import 'package:sqflite/sqflite.dart';
import 'aluno_disciplina_entity.dart';
import 'conexao.dart';
import 'data_container.dart';

class AlunoDisciplinaSQLiteDataSource {
  Future create(AlunoDisciplinaEntity aluno_disciplina) async {
    print("* * * * * * * * CREATE ALUNO_DISCIPLINA * * * * * * * *");
    try {
      final Database db = await Conexao.getConexaoDB();
      aluno_disciplina.aluno_disciplinaID =
          await db.rawInsert('''insert into $ALUNODISCIPLINA_TABLE_NAME(
        $ALUNODISCIPLINA_COLUMN_ALUNO_ID, $ALUNODISCIPLINA_COLUMN_DISCIPLINA_ID)
        values(
          ${aluno_disciplina.aluno?.alunoID}, ${aluno_disciplina.disciplina?.disciplinaID}
      )''');
      queryAllRows();
      return true;
    } catch (ex) {
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await Conexao.getConexaoDB();
    return await db.query(ALUNODISCIPLINA_TABLE_NAME);
  }

  Future<List<AlunoDisciplinaEntity>> getAllAlunoDisciplina() async {
    Database db = await Conexao.getConexaoDB();
    List<Map> dnResult =
        await db.rawQuery('SELECT * FROM $ALUNODISCIPLINA_TABLE_NAME');

    List<AlunoDisciplinaEntity> aluno_disciplinas = [];
    for (var row in dnResult) {
      AlunoDisciplinaEntity aluno_disciplina = AlunoDisciplinaEntity();
      aluno_disciplina.aluno_disciplinaID = row['aluno_disciplinaID'];
      aluno_disciplina.aluno?.alunoID = row['alunoID'];
      aluno_disciplina.disciplina?.disciplinaID = row['disciplinaID'];

      aluno_disciplinas.add(aluno_disciplina);
    }
    return aluno_disciplinas;
  }

  Future<void> atualizarAlunoDisciplina(
      AlunoDisciplinaEntity aluno_disciplina) async {
    Database db = await Conexao.getConexaoDB();
    await db.transaction((txn) async {
      await txn.rawUpdate(
          'update $ALUNODISCIPLINA_TABLE_NAME set $ALUNODISCIPLINA_COLUMN_ALUNO_ID = ?, $ALUNODISCIPLINA_COLUMN_ALUNO_ID where id = ?',
          [
            aluno_disciplina.disciplina?.disciplinaID,
            aluno_disciplina.aluno?.alunoID,
            aluno_disciplina.aluno_disciplinaID,
          ]);
    });
  }

  Future<void> deletarAlunoDisciplina(
      AlunoDisciplinaEntity aluno_disciplina) async {
    Database db = await Conexao.getConexaoDB();
    await db.transaction((txn) async {
      await txn.rawUpdate(
          'DELETE FROM $ALUNODISCIPLINA_TABLE_NAME WHERE $ALUNODISCIPLINA_COLUMN_ID = ?',
          [aluno_disciplina.aluno_disciplinaID]);
    });
  }

  Future<void> deletarAlunoPorDisciplina(DisciplinaEntity disciplina) async {
    Database db = await Conexao.getConexaoDB();
    await db.transaction((txn) async {
      await txn.rawUpdate(
          'DELETE FROM $ALUNODISCIPLINA_TABLE_NAME WHERE $ALUNODISCIPLINA_COLUMN_DISCIPLINA_ID =  ?',
          [disciplina.disciplinaID]);
    });
  }

  Future<List<AlunoDisciplinaEntity>> getAlunosPorDisciplina(
      DisciplinaEntity disciplina) async {
    print("* * * * * * * * GET ALUNOS POR DISCIPLINA * * * * * * * *");
    Database db = await Conexao.getConexaoDB();
    List<AlunoDisciplinaEntity> aluno_disciplinas = [];
    try {
      List<Map> dnResult = await db.rawQuery(
          'SELECT * FROM $ALUNODISCIPLINA_TABLE_NAME ' +
              'LEFT JOIN $ALUNO_TABLE_NAME ON $ALUNO_TABLE_NAME.$ALUNODISCIPLINA_COLUMN_ALUNO_ID = $ALUNODISCIPLINA_TABLE_NAME.$ALUNO_COLUMN_ID ' +
              'LEFT JOIN $DISCIPLINA_TABLE_NAME ON $ALUNODISCIPLINA_TABLE_NAME.$ALUNODISCIPLINA_COLUMN_DISCIPLINA_ID = $DISCIPLINA_TABLE_NAME.$DISCIPLINA_COLUMN_ID ' +
              'WHERE $ALUNODISCIPLINA_TABLE_NAME.$ALUNODISCIPLINA_COLUMN_DISCIPLINA_ID = ?',
          [disciplina.disciplinaID]);

      for (var row in dnResult) {
        AlunoDisciplinaEntity aluno_disciplina = AlunoDisciplinaEntity();
        aluno_disciplina.aluno = new AlunoEntity();
        aluno_disciplina.disciplina = new DisciplinaEntity();

        aluno_disciplina.aluno_disciplinaID = row['$ALUNODISCIPLINA_COLUMN_ID'];
        aluno_disciplina.aluno?.alunoID = row['$ALUNO_COLUMN_ID'];
        aluno_disciplina.aluno?.nome = row['$ALUNO_COLUMN_NOME'];
        aluno_disciplina.disciplina?.disciplinaID =
            row['$DISCIPLINA_COLUMN_ID'];
        aluno_disciplina.disciplina?.nome = row['$DISCIPLINA_COLUMN_NOME'];
        aluno_disciplina.disciplina?.perfil?.perfilID =
            row['$DISCIPLINA_COLUMN_PERFIL_ID'];

        aluno_disciplinas.add(aluno_disciplina);
      }
      return aluno_disciplinas;
    } catch (ex) {
      print(ex);
      return aluno_disciplinas;
    }
  }

  Future<List<AlunoDisciplinaEntity>> pesquisarDisciplinas(
      String filtro) async {
    List<AlunoDisciplinaEntity> aluno_disciplinas = [];
    Database db = await Conexao.getConexaoDB();
    List<Map> dbResult = await db.rawQuery(
        'SELECT * FROM $ALUNODISCIPLINA_TABLE_NAME WHERE $ALUNODISCIPLINA_COLUMN_ALUNO_ID LIKE ?',
        ['%$filtro%']);
    for (var row in dbResult) {
      AlunoDisciplinaEntity aluno_disciplina = AlunoDisciplinaEntity();
      aluno_disciplina.aluno_disciplinaID = row['aluno_disciplinaID'];
      aluno_disciplina.aluno?.alunoID = row['alunoID'];
      aluno_disciplina.disciplina?.disciplinaID = row['disciplinaID'];
      aluno_disciplinas.add(aluno_disciplina);
    }
    return aluno_disciplinas;
  }
}
