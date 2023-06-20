import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'disciplina_entity.dart';
import 'conexao.dart';
import 'data_container.dart';

class DisciplinaSQLiteDataSource {
  Future create(DisciplinaEntity disciplina) async {
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
    Database db = await Conexao.getConexaoDB();
    List<Map> dnResult =
        await db.rawQuery('SELECT * FROM $DISCIPLINA_TABLE_NAME');

    List<DisciplinaEntity> disciplinas = [];
    for (var row in dnResult) {
      DisciplinaEntity disciplina = DisciplinaEntity();
      disciplina.disciplinaID = row['disciplinaID'];
      disciplina.nome = row['nome'];
      disciplina.perfil?.perfilID = row['professor_id'];

      disciplinas.add(disciplina);
    }
    return disciplinas;
  }

  Future<void> atualizarDisciplina(DisciplinaEntity disciplina) async {
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

  Future<void> deletarDisciplina(DisciplinaEntity disciplina) async {
    Database db = await Conexao.getConexaoDB();
    await db.transaction((txn) async {
      await txn.rawUpdate('DELETE FROM $DISCIPLINA_TABLE_NAME WHERE id = ?',
          [disciplina.disciplinaID]);
    });
  }

  Future<List<DisciplinaEntity>> pesquisarSenha(String filtro) async {
    List<DisciplinaEntity> disciplinas = [];
    Database db = await Conexao.getConexaoDB();
    List<Map> dbResult = await db.rawQuery(
        'SELECT * FROM $DISCIPLINA_TABLE_NAME WHERE $DISCIPLINA_COLUMN_NOME LIKE ?',
        ['%$filtro%']);
    for (var row in dbResult) {
      DisciplinaEntity disciplina = DisciplinaEntity();
      disciplina.disciplinaID = row['disciplinaID'];
      disciplina.nome = row['nome'];
      disciplina.perfil?.perfilID = row['professor_id'];
      disciplinas.add(disciplina);
    }
    return disciplinas;
  }
  Future<void> deletarDisciplinas() async {
    Database db = await Conexao.getConexaoDB();
    await db.transaction((txn) async {
      await txn.rawDelete('delete from $DISCIPLINA_TABLE_NAME');
    });
  }
}
