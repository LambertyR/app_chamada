import 'package:chamada_univel/data/aluno_disciplina_entity.dart';
import 'package:chamada_univel/data/aluno_entity.dart';
import 'package:chamada_univel/data/disciplina_entity.dart';
import 'package:chamada_univel/data/perfil_entity.dart';
import 'package:chamada_univel/data/presenca_entity.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'conexao.dart';
import 'data_container.dart';

class PresencaSQLiteDataSource {
  Future create(PresencaEntity presenca) async {
    print("* * * * * * * * CREATE PRESENÇA * * * * * * * *");
    try {
      final Database db = await Conexao.getConexaoDB();
      presenca.presencaID =
          await db.rawInsert('''insert into $PRESENCA_TABLE_NAME(
        $PRESENCA_COLUMN_DATA, $PRESENCA_COLUMN_ALUNODISCIPLINA_ID)
        values(
          '${presenca.data}', ${presenca.aluno_disciplina?.aluno_disciplinaID}
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

  Future<List<PresencaEntity>> getAllPresencaPorDisciplina(
      DisciplinaEntity disciplina) async {
    print("* * * * * * * * GET ALL PRESENÇAS POR DISCIPLINA * * * * * * * *");
    Database db = await Conexao.getConexaoDB();
    print(disciplina.disciplinaID);
    List<Map> dnResult = await db
        .rawQuery('''SELECT $PRESENCA_COLUMN_DATA FROM $PRESENCA_TABLE_NAME 
        LEFT JOIN $ALUNODISCIPLINA_TABLE_NAME ON $ALUNODISCIPLINA_TABLE_NAME.$ALUNODISCIPLINA_COLUMN_ID = 
        $PRESENCA_TABLE_NAME.$PRESENCA_COLUMN_ALUNODISCIPLINA_ID WHERE 
        $ALUNODISCIPLINA_TABLE_NAME.$ALUNODISCIPLINA_COLUMN_DISCIPLINA_ID = ? 
        GROUP BY $PRESENCA_COLUMN_DATA 
        ORDER BY $PRESENCA_COLUMN_DATA ASC''', [disciplina.disciplinaID]);
    List<PresencaEntity> presencas = [];
    for (var row in dnResult) {
      PresencaEntity presenca = PresencaEntity();
      presenca.aluno_disciplina = AlunoDisciplinaEntity();

      presenca.presencaID = row['$PRESENCA_COLUMN_ID'];
      presenca.data = DateTime.parse(row['$PRESENCA_COLUMN_DATA']);
      presenca.aluno_disciplina?.aluno_disciplinaID =
          row['$PRESENCA_COLUMN_ALUNODISCIPLINA_ID'];

      presencas.add(presenca);
    }
    return presencas;
  }

  Future<List<PresencaEntity>> getAllPresencaPorData(
      DisciplinaEntity disciplina, DateTime data) async {
    print("* * * * * * * * GET ALL PRESENÇAS POR DATA * * * * * * * *");
    Database db = await Conexao.getConexaoDB();
    print(disciplina.disciplinaID);
    List<Map> dnResult =
        await db.rawQuery('''SELECT * FROM $PRESENCA_TABLE_NAME 
        LEFT JOIN $ALUNODISCIPLINA_TABLE_NAME ON $ALUNODISCIPLINA_TABLE_NAME.$ALUNODISCIPLINA_COLUMN_ID = 
        $PRESENCA_TABLE_NAME.$PRESENCA_COLUMN_ALUNODISCIPLINA_ID 
        LEFT JOIN $ALUNO_TABLE_NAME ON $ALUNODISCIPLINA_TABLE_NAME.$ALUNODISCIPLINA_COLUMN_ALUNO_ID = 
        $ALUNO_TABLE_NAME.$ALUNO_COLUMN_ID WHERE 
        $ALUNODISCIPLINA_TABLE_NAME.$ALUNODISCIPLINA_COLUMN_DISCIPLINA_ID = ? AND $PRESENCA_COLUMN_DATA LIKE ? 
        AND $ALUNODISCIPLINA_COLUMN_FALTA == 0''', [
      disciplina.disciplinaID,
      '%$data%',
    ]);
    List<PresencaEntity> presencas = [];
    for (var row in dnResult) {
      PresencaEntity _presenca = PresencaEntity();
      _presenca.aluno_disciplina = AlunoDisciplinaEntity();
      _presenca.aluno_disciplina!.aluno = AlunoEntity();
      _presenca.aluno_disciplina!.disciplina = DisciplinaEntity();
      _presenca.aluno_disciplina!.disciplina!.perfil = PerfilEntity();

      _presenca.presencaID = row['$PRESENCA_COLUMN_ID'];
      _presenca.data = DateTime.parse(row['$PRESENCA_COLUMN_DATA']);
      if (row['$ALUNODISCIPLINA_COLUMN_FALTA'] == 0) {
        _presenca.aluno_disciplina?.falta = false;
      } else {
        _presenca.aluno_disciplina?.falta = true;
      }
      _presenca.aluno_disciplina?.aluno_disciplinaID =
          row['$PRESENCA_COLUMN_ALUNODISCIPLINA_ID'];
      _presenca.aluno_disciplina?.aluno?.alunoID = row['$ALUNO_COLUMN_ID'];
      _presenca.aluno_disciplina?.aluno?.nome = row['$ALUNO_COLUMN_NOME'];
      _presenca.aluno_disciplina?.aluno?.registro =
          row['$ALUNO_COLUMN_REGISTRO'];
      _presenca.aluno_disciplina?.disciplina?.disciplinaID =
          row['$DISCIPLINA_COLUMN_ID'];
      _presenca.aluno_disciplina?.disciplina?.nome =
          row['$DISCIPLINA_COLUMN_NOME'];

      presencas.add(_presenca);
    }
    return presencas;
  }

  Future<void> atualizarPresenca(PresencaEntity presenca) async {
    Database db = await Conexao.getConexaoDB();
    await db.transaction((txn) async {
      await txn.rawUpdate(
          'update $PRESENCA_TABLE_NAME set $PRESENCA_COLUMN_DATA = ?,  $PRESENCA_COLUMN_ALUNODISCIPLINA_ID = ? where id = ?',
          [
            presenca.data,
            presenca.aluno_disciplina?.aluno_disciplinaID,
            presenca.presencaID
          ]);
    });
  }

  Future<void> deletarPresencas() async {
    Database db = await Conexao.getConexaoDB();
    await db.transaction((txn) async {
      await txn.rawUpdate('DELETE FROM $PRESENCA_TABLE_NAME');
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
