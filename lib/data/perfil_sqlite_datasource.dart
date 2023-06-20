import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'perfil_entity.dart';
import 'conexao.dart';
import 'data_container.dart';

class PerfilSQLiteDataSource {
  Future create(PerfilEntity perfil) async {
    try {
      final Database db = await Conexao.getConexaoDB();
      perfil.perfilID = await db.rawInsert('''insert into $PERFIL_TABLE_NAME(
        $PERFIL_COLUMN_NOME,
        $PERFIL_COLUMN_EMAIL,
        $PERFIL_COLUMN_SENHA)
        values(
          '${perfil.nome}', '${perfil.email}', '${perfil.senha}'
      )''');
      queryAllRows();
      return true;
    } catch (ex) {
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await Conexao.getConexaoDB();
    return await db.query(PERFIL_TABLE_NAME);
  }

  Future<List<PerfilEntity>> getAllPerfil() async {
    Database db = await Conexao.getConexaoDB();
    List<Map> dnResult = await db.rawQuery('SELECT * FROM $PERFIL_TABLE_NAME');

    List<PerfilEntity> perfis = [];
    for (var row in dnResult) {
      PerfilEntity perfil = PerfilEntity();
      perfil.perfilID = row['perfilID'];
      perfil.nome = row['nome'];
      perfil.email = row['email'];
      perfil.senha = row['senha'];
      //perfil.foto = row['foto'];
      perfis.add(perfil);
    }
    return perfis;
  }

  Future<void> atualizarPerfil(PerfilEntity perfil) async {
    Database db = await Conexao.getConexaoDB();
    await db.transaction((txn) async {
      await txn.rawUpdate(
          'update $PERFIL_TABLE_NAME set $PERFIL_COLUMN_NOME = ?, $PERFIL_COLUMN_EMAIL = ?, $PERFIL_COLUMN_SENHA = ? where id = ?',
          //$PERFIL_COLUMN_FOTO = ?
          [perfil.nome, perfil.email, perfil.senha]); //, perfil.foto]);
    });
  }

  Future<void> deletarPerfis(PerfilEntity perfil) async {
    Database db = await Conexao.getConexaoDB();
    await db.transaction((txn) async {
      await txn.rawUpdate(
          'DELETE FROM $PERFIL_TABLE_NAME WHERE id = ?', [perfil.perfilID]);
    });
  }

  Future<List<PerfilEntity>> pesquisarSenha(String filtro) async {
    List<PerfilEntity> perfis = [];
    Database db = await Conexao.getConexaoDB();
    List<Map> dbResult = await db.rawQuery(
        'SELECT * FROM $PERFIL_TABLE_NAME WHERE $PERFIL_COLUMN_NOME LIKE ?',
        ['%$filtro%']);
    for (var row in dbResult) {
      PerfilEntity perfil = PerfilEntity();
      perfil.perfilID = row['perfilID'];
      perfil.nome = row['nome'];
      perfil.email = row['email'];
      perfil.senha = row['senha'];
      // perfil.foto = row['foto'];
      perfis.add(perfil);
    }
    return perfis;
  }

  Future<bool> getPerfilLogin(login, senha) async {
    Database db = await Conexao.getConexaoDB();
    List<Map> dbResult = await db.rawQuery(
        'SELECT * from $PERFIL_TABLE_NAME where $PERFIL_COLUMN_EMAIL = "${login}" and $PERFIL_COLUMN_SENHA = "${senha}"');

    if (dbResult.isEmpty)
      return false;
    else
      return true;
  }
}
