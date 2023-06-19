import 'package:sqflite/sqflite.dart';
import 'aluno_entity.dart';
import 'conexao.dart';
import 'data_container.dart';

class AlunoSQLiteDataSource {
  Future create(AlunoEntity aluno) async {
    try {
      final Database db = await Conexao.getConexaoDB();
      aluno.alunoID = await db.rawInsert('''insert into $ALUNO_TABLE_NAME(
        $ALUNO_COLUMN_NOME)
        values(
          '${aluno.nome}'
      )''');
      queryAllRows();
      return true;
    } catch (ex) {
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await Conexao.getConexaoDB();
    return await db.query(ALUNO_TABLE_NAME);
  }

  Future<List<AlunoEntity>> getAllAluno() async {
    Database db = await Conexao.getConexaoDB();
    List<Map> dnResult = await db.rawQuery('SELECT * FROM $ALUNO_TABLE_NAME');

    List<AlunoEntity> alunos = [];
    for (var row in dnResult) {
      AlunoEntity aluno = AlunoEntity();
      aluno.alunoID = row['alunoID'];
      aluno.nome = row['nome'];

      alunos.add(aluno);
    }
    return alunos;
  }

  Future<void> atualizarAluno(AlunoEntity aluno) async {
    Database db = await Conexao.getConexaoDB();
    await db.transaction((txn) async {
      await txn.rawUpdate(
          'update $ALUNO_TABLE_NAME set $ALUNO_COLUMN_NOME = ? where id = ?', [
        aluno.nome,
        aluno.alunoID,
      ]);
    });
  }

  Future<void> deletarPerfis(AlunoEntity aluno) async {
    Database db = await Conexao.getConexaoDB();
    await db.transaction((txn) async {
      await txn.rawUpdate(
          'DELETE FROM $ALUNO_TABLE_NAME WHERE id = ?', [aluno.alunoID]);
    });
  }

  Future<List<AlunoEntity>> pesquisarSenha(String filtro) async {
    List<AlunoEntity> alunos = [];
    Database db = await Conexao.getConexaoDB();
    List<Map> dbResult = await db.rawQuery(
        'SELECT * FROM $ALUNO_TABLE_NAME WHERE $ALUNO_COLUMN_NOME LIKE ?',
        ['%$filtro%']);
    for (var row in dbResult) {
      AlunoEntity aluno = AlunoEntity();
      aluno.alunoID = row['alunoID'];
      aluno.nome = row['nome'];
      alunos.add(aluno);
    }
    return alunos;
  }
}
