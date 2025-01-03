import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../../../constants/app_constants.dart';

class AppDB {
  static const _databaseName = AppConstants.databaseName;
  static String get databaseName => _databaseName;
  static const _databaseVersion = 1;

  // Memo Table
  static const taskTable = 'tasks';
  static const taskColumnId = '_id';
  static const taskTitle = 'title';
  static const taskDescription = 'description';
  static const isCompleted = 'isCompleted';

  Database? _database;
  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDBPath();

    return await openDatabase(
      databasePath,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $taskTable (
      $taskColumnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $taskTitle TEXT NOT NULL,
      $taskDescription TEXT NOT NULL,
      $isCompleted INTEGER NOT NULL
    )
    ''');
  }

  Future<String> getDBPath() async {
    final path = await getDatabasesPath();
    return join(path, _databaseName);
  }

  Future<void> closeDB() async {
    final db = await database;
    await db.close();
  }

}