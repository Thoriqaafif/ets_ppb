import 'package:sqflite/sqflite.dart';

abstract class DatabaseService {
  Database? _database;
  static final Map<String, String> type = {
    'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
    'bool': 'BOOLEAN NOT NULL',
    'int': 'INTEGER NOT NULL',
    'text': 'TEXT NOT NULL',
  };

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initialize();
    return _database!;
  }

  Future<String> get fullPath;

  Future<Database> _initialize() async {
    final path = await fullPath;
    var database = await openDatabase(
        path,
        version: 1,
        onCreate: createTable,
        singleInstance: true
    );
    return database;
  }

  Future<void> createTable(Database database, int version);

  Future<void> close() async {
    final db = await database;

    db.close();
  }
}