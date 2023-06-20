import 'package:sqflite/sqflite.dart';
import 'aluno_disciplina_entity.dart';
import 'conexao.dart';
import 'data_container.dart';

class AlunoDisciplinaSQLiteDataSource {
  Future create(AlunoDisciplinaEntity aluno_disciplina) async {
    try {
      final Database db = await Conexao.getConexaoDB();
      aluno_disciplina.aluno_disciplinaID =
          await db.rawInsert('''insert into $ALUNODISCIPLINA_TABLE_NAME(
        $ALUNODISCIPLINA_COLUMN_ALUNOID, $ALUNODISCIPLINA_COLUMN_DISCIPLINAID)
        values(
          '${aluno_disciplina.alunoID}, ${aluno_disciplina.disciplinaID}'
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
      aluno_disciplina.alunoID = row['alunoID'];
      aluno_disciplina.disciplinaID = row['disciplinaID'];

      aluno_disciplinas.add(aluno_disciplina);
    }
    return aluno_disciplinas;
  }

  Future<void> atualizarAlunoDisciplina(
      AlunoDisciplinaEntity aluno_disciplina) async {
    Database db = await Conexao.getConexaoDB();
    await db.transaction((txn) async {
      await txn.rawUpdate(
          'update $ALUNODISCIPLINA_TABLE_NAME set $ALUNODISCIPLINA_COLUMN_ALUNOID = ?, $ALUNODISCIPLINA_COLUMN_DISCIPLINAID where id = ?',
          [
            aluno_disciplina.disciplinaID,
            aluno_disciplina.alunoID,
            aluno_disciplina.aluno_disciplinaID,
          ]);
    });
  }

  Future<void> deletarPerfis(AlunoDisciplinaEntity aluno_disciplina) async {
    Database db = await Conexao.getConexaoDB();
    await db.transaction((txn) async {
      await txn.rawUpdate(
          'DELETE FROM $ALUNODISCIPLINA_TABLE_NAME WHERE id = ?',
          [aluno_disciplina.aluno_disciplinaID]);
    });
  }

  Future<List<AlunoDisciplinaEntity>> pesquisarDisciplinas(
      String filtro) async {
    List<AlunoDisciplinaEntity> aluno_disciplinas = [];
    Database db = await Conexao.getConexaoDB();
    List<Map> dbResult = await db.rawQuery(
        'SELECT * FROM $ALUNODISCIPLINA_TABLE_NAME WHERE $ALUNODISCIPLINA_COLUMN_ALUNOID LIKE ?',
        ['%$filtro%']);
    for (var row in dbResult) {
      AlunoDisciplinaEntity aluno_disciplina = AlunoDisciplinaEntity();
      aluno_disciplina.aluno_disciplinaID = row['aluno_disciplinaID'];
      aluno_disciplina.alunoID = row['alunoID'];
      aluno_disciplina.disciplinaID = row['disciplinaID'];
      aluno_disciplinas.add(aluno_disciplina);
    }
    return aluno_disciplinas;
  }
}
