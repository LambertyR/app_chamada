import 'package:sqflite/sqflite.dart';
import 'aluno_entity.dart';
import 'conexao.dart';
import 'data_container.dart';

class AlunoSQLiteDataSource {
  Future create(AlunoEntity aluno) async {
    print("* * * * * * * * CREATE ALUNO * * * * * * * *");
    try {
      final Database db = await Conexao.getConexaoDB();
      aluno.alunoID = await db.rawInsert('''insert into $ALUNO_TABLE_NAME(
        $ALUNO_COLUMN_NOME, $ALUNO_COLUMN_REGISTRO)
        values(
          '${aluno.nome}',${aluno.registro}
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

  Future<bool> verificaRegistro(AlunoEntity alunoFiltro) async {
    print("* * * * * * * * VERIFICA REGISTRO * * * * * * * *");
    Database db = await Conexao.getConexaoDB();
    try {
      List<Map> dnResult = await db.rawQuery(
          'SELECT * FROM $ALUNO_TABLE_NAME ' +
              'WHERE $ALUNO_COLUMN_REGISTRO = ?',
          ['${alunoFiltro.registro}']);
      if (dnResult.isEmpty) {
        return false;
      }
      return true;
    } catch (ex) {
      print(ex);
      return false;
    }
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

  Future<void> deletarAluno(AlunoEntity aluno) async {
    Database db = await Conexao.getConexaoDB();
    await db.transaction((txn) async {
      await txn.rawUpdate(
          'DELETE FROM $ALUNO_TABLE_NAME WHERE id = ?', [aluno.alunoID]);
    });
  }

  Future<AlunoEntity> pesquisarAluno(AlunoEntity _aluno) async {
    Database db = await Conexao.getConexaoDB();
    List<Map> dbResult = await db.rawQuery(
        'SELECT * FROM $ALUNO_TABLE_NAME ' + 'WHERE $ALUNO_COLUMN_REGISTRO = ?',
        ['${_aluno.registro}']);
    AlunoEntity aluno = AlunoEntity();
    for (var row in dbResult) {
      aluno.alunoID = row['alunoID'];
      aluno.nome = row['nome'];
      aluno.registro = row['registro'];
    }
    return aluno;
  }
}
