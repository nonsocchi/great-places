import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    // Get a location using getDatabasesPath
    final dbPath = await sql.getDatabasesPath();

    // open the database
    return sql.openDatabase(
      path.join(dbPath, 'places.db'),
      // When creating the db, create the table
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE user_places (id TEXT PRIMARY KEY, title TEXT, image TEXT)');
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await DBHelper.database();

    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();

    return db.query(table);
  }
}
