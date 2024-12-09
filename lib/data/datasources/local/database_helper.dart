import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> getDatabase() async {
    if (_database != null) {
      return _database!;
    }

    if (kIsWeb) {
      final databaseFactory = databaseFactoryFfiWeb;
      _database = await databaseFactory.openDatabase('workout_database.db', );
      await _createTables(_database!,1);
    } else {
      final directory = await getDatabasesPath();
      final path = join(directory, 'workout_database.db');
      _database = await openDatabase(path, version: 1, onCreate: _createTables);
    }

    return _database!;
  }

  static Future<void> _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS workouts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        type INTEGER NOT NULL,
        distance REAL NOT NULL,
        duration INTEGER NOT NULL,
        routeSnapshot TEXT NOT NULL,
        timestamp TEXT
      );
      CREATE TABLE IF NOT EXISTS goals (
      id TEXT PRIMARY KEY,
      userId TEXT NOT NULL, 
      goalType TEXT,
      goalValue REAL)
    ''');
  }
}
