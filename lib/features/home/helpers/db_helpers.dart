
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'user_places.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, latitude REAL, longitude REAL)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    await db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // final result = await db.rawQuery('SELECT COUNT(*) FROM user_places');
    // final count = Sqflite.firstIntValue(result);
    // log(count.toString());
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<void> deleteTable() async {
    final db = await database();
    await db.delete('user_places');
    // final result = await db.rawQuery('SELECT COUNT(*) FROM user_places');
    // final count = Sqflite.firstIntValue(result);
    // log(count.toString());
  }
}
