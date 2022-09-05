import 'package:app/models/casheduser.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  LocalDatabase._init();
  static final LocalDatabase getInstance = LocalDatabase._init();
  static Database? _database;

  factory LocalDatabase() {
    return getInstance;
  }
  // yangi ustanovka qilgandan so'ng bir marta databaza yaratiladi keyin ilovani o'cirmaguncha qolib ketadi
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB(CachedUserFields.databaseName);
      return _database!;
    }
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const intType = "INTEGER DEFAULT 0";
    const boolType = 'BOOLEAN NOT NULL';

    await db.execute("""
    CREATE TABLE ${CachedUserFields.tableName} (
      ${CachedUserFields.id} $idType,
      ${CachedUserFields.name} $textType,
      ${CachedUserFields.age} $intType
    )
    """);
  }

  static Future<int> insertUser({
    required String name,
    required int age,
  }) async {
    final database = await getInstance.database;
    return database.insert(CachedUserFields.tableName, {
      CachedUserFields.name: name,
      CachedUserFields.age: age,
    });
  }

 

  static Future<int> deleteUser() async {
    final database = await getInstance.database;
    return database.delete(CachedUserFields.tableName);
  }

  static Future<List<CachedUser>> getAllCachedUsers() async {
    final database = await getInstance.database;
    List data = await database.query(CachedUserFields.tableName);
    return data.map((json) => CachedUser.fromJson(json)).toList();
  }
}
