import 'package:sqflite/sqflite.dart';

class BancoDeDados {
  static BancoDeDados? _instance;
  Database? db;
  String onCreateSQL = '''
    CREATE TABLE fotos (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      picture BLOB,
      date TEXT,
      latitude REAL,
      longitude REAL,
      titulo TEXT,
      descricao TEXT
    );
  ''';

  BancoDeDados._privado();
  factory BancoDeDados() {
    return _instance ??= BancoDeDados._privado();
  }

  Future<void> onCreate(Database db, int version) async {
    await db.execute(onCreateSQL);
  }

  Future<void> openDb() async {
    if (db == null) {
      return getDatabasesPath().then((value) {
        String path = value + 'fotos.db';
        return openDatabase(path, onCreate: onCreate, version: 1).then((value) {
          db = value;
        });
      });
    }
  }

  Future<void> deleteDb() async {
    return getDatabasesPath().then((value) async {
      String path = value + 'fotos.db';
      return await deleteDatabase(path);
    });
  }
}
