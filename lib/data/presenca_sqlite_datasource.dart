import 'package:chamada_univel/data/presenca_entity.dart';
import 'package:sqflite/sqflite.dart';
import 'conexao.dart';
import 'data_container.dart';

class PresencaSQLiteDataSource {
  Future create(PresencaEntity presenca) async {
    try {
      final Database db = await Conexao.getConexaoDB();
      presenca.presencaID =
          await db.rawInsert('''insert into $PRESENCA_TABLE_NAME(
        $PRESENCA_COLUMN_DATA, $PRESENCA_COLUMN_ALUNODISCIPLINA_ID)
        values(
          '${presenca.data}, ${presenca.aluno_disciplina?.aluno_disciplinaID}'
      )''');
      queryAllRows();
      return true;
    } catch (ex) {
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await Conexao.getConexaoDB();
    return await db.query(PRESENCA_TABLE_NAME);
  }

  Future<List<PresencaEntity>> getAllPresenca() async {
    Database db = await Conexao.getConexaoDB();
    List<Map> dnResult =
        await db.rawQuery('SELECT * FROM $PRESENCA_TABLE_NAME');

    List<PresencaEntity> presencas = [];
    for (var row in dnResult) {
      PresencaEntity presenca = PresencaEntity();
      presenca.presencaID = row['presencaID'];
      presenca.data = row['nome'];
      presenca.aluno_disciplina?.aluno_disciplinaID = row['aluno_disciplinaID'];
      presencas.add(presenca);
    }
    return presencas;
  }

  Future<void> atualizarPresenca(PresencaEntity presenca) async {
    Database db = await Conexao.getConexaoDB();
    await db.transaction((txn) async {
      await txn.rawUpdate(
          'update $PRESENCA_TABLE_NAME set $PRESENCA_COLUMN_DATA = ?,  $PRESENCA_COLUMN_ALUNODISCIPLINA_ID = ? where id = ?',
          [presenca.data, presenca.aluno_disciplina?.aluno_disciplinaID, presenca.presencaID]);
    });
  }

  Future<void> deletarPerfis(PresencaEntity presenca) async {
    Database db = await Conexao.getConexaoDB();
    await db.transaction((txn) async {
      await txn.rawUpdate('DELETE FROM $PRESENCA_TABLE_NAME WHERE id = ?',
          [presenca.presencaID]);
    });
  }

  Future<List<PresencaEntity>> pesquisarData(String filtro) async {
    List<PresencaEntity> perfis = [];
    Database db = await Conexao.getConexaoDB();
    List<Map> dbResult = await db.rawQuery(
        'SELECT * FROM $PRESENCA_TABLE_NAME WHERE $PRESENCA_COLUMN_DATA LIKE ?',
        ['%$filtro%']);
    for (var row in dbResult) {
      PresencaEntity presenca = PresencaEntity();
      presenca.presencaID = row['presencaID'];
      presenca.data = row['data'];
      perfis.add(presenca);
    }
    return perfis;
  }
}
