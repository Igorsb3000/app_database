import 'package:flutter_database_app/domain/livro.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LivroHelper {
  //singleton
  //construtor interno
  static final LivroHelper _instance = LivroHelper.internal();

  //criação do factory para retornar a instância
  factory LivroHelper() => _instance;

  //LivroHelper.instance
  LivroHelper.internal();

  Database? _db;

  Future<Database?> get db async {
    if (_db == null) _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    String? databasesPath = await getDatabasesPath();
    if (databasesPath == null) databasesPath = "";
    String path = join(databasesPath, "livros.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
          await db.execute(
              "CREATE TABLE ${Livro.livroTable}(${Livro.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT, "
                  "                                 ${Livro.tituloColumn} TEXT, "
                  "                                 ${Livro.autorColumn} TEXT, "
                  "                                 ${Livro.anoPublicacaoColumn} INTEGER, "
                  "                                 ${Livro.avaliacaoColumn} REAL) ");
        });
  }

  Future<void> close() async {
    Database? dbLivro = await db;
    if (dbLivro != null && dbLivro.isOpen) {
      await dbLivro.close();
      _db = null; // Definir como null para indicar que o banco foi fechado
    }
  }

  Future<Livro> saveLivro(Livro l) async {
    Database? dbLivro = await db;
    if (dbLivro != null) {
      l.id = await dbLivro.insert(Livro.livroTable, l.toMap());
    }
    return l;
  }

  Future<Livro?> getLivro(int id) async {
    Database? dbLivro = await db;
    if (dbLivro != null) {
      List<Map> maps = await dbLivro.query(Livro.livroTable,
          columns: [
            Livro.idColumn,
            Livro.tituloColumn,
            Livro.autorColumn,
            Livro.anoPublicacaoColumn,
            Livro.avaliacaoColumn
          ],
          where: "${Livro.idColumn} = ?",
          whereArgs: [id]);
      if (maps.length > 0)
        return Livro.fromMap(maps.first);
      else
        return null;
    }
    return null;
  }

  Future<int> deleteLivro(int id) async {
    Database? dbLivro = await db;
    if (dbLivro!= null) {
      return await dbLivro.delete(Livro.livroTable,
          where: "${Livro.idColumn} = ?", whereArgs: [id]);
    } else
      return 0;
  }

  Future<int> updateLivro(Livro l) async {
    Database? dbLivro = await db;
    if (dbLivro != null) {
      print('Achou o livro na TABELA item = ${l.id}');
      return await dbLivro.update(Livro.livroTable, l.toMap(),
          where: "${Livro.idColumn} = ?", whereArgs: [l.id]);
    } else {
      print('NAO achou o livro na TABELA');
      return 0;
    }
  }

  Future<List> getAll() async {
    Database? dbLivro = await db;
    if (dbLivro != null) {
      List listMap = await dbLivro.query(Livro.livroTable);
      List<Livro> listLivros = [];

      for (Map m in listMap) {
        listLivros.add(Livro.fromMap(m));
      }
      return listLivros;
    } else {
      return [];
    }
  }
}
