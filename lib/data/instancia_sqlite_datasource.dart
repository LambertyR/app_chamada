import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'instancia_entity.dart';
import 'conexao.dart';
import 'data_container.dart';

class InstanciaSQLiteDataSource {
  Future create(InstanciaEntity instancia) async {
    print("* * * * * * * * CREATE INSTANCIAS * * * * * * * *");
    try {
      final Database db = await Conexao.getConexaoDB();
      instancia.instanciaID =
          await db.rawInsert('''insert into $INSTANCIA_TABLE_NAME(
        $INSTANCIA_COLUMN_ID)
        values(
          '${instancia.instanciaID}'
      )''');
      queryAllRows();
      return true;
    } catch (ex) {
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await Conexao.getConexaoDB();
    return await db.query(INSTANCIA_TABLE_NAME);
  }

  Future<InstanciaEntity> getAllInstancia() async {
    print("* * * * * * * * GET ALL INSTANCIAS * * * * * * * *");
    Database db = await Conexao.getConexaoDB();
    InstanciaEntity instancia = new InstanciaEntity();
    try {
      instancia.instanciaID = 0;
      List<Map> dnResult =
          await db.rawQuery('SELECT * FROM $INSTANCIA_TABLE_NAME');

      for (var row in dnResult) {
        instancia.instanciaID = row['instanciaID'];
      }
      return instancia;
    } catch (ex) {
      print(ex);
      return instancia;
    }
  }

  Future<void> deletarInstancias() async {
    print("* * * * * * * * DELETAR INSTANCIAS * * * * * * * *");
    Database db = await Conexao.getConexaoDB();
    try {
      await db.transaction((txn) async {
        await txn.rawDelete('delete from $INSTANCIA_TABLE_NAME');
      });
    } catch (ex) {
      print(ex);
    }
  }
}
