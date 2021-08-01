import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database(table) async {
    var exPath = await getExternalStorageDirectory();
    final dbPath = path.join(exPath!.path, "core.db");
    return await sql.openDatabase(
      dbPath,
      onCreate: (sql.Database db, int version) async {
        print("creating >>> $table");
        await db.execute(
            'CREATE TABLE IF NOT EXISTS Readings (id TEXT PRIMARY KEY,title TEXT, sizeInMB REAL, author TEXT,isBook INTEGER, url TEXT, path TEXT)');
        db.execute(
            'CREATE TABLE IF NOT EXISTS Podcasts (id TEXT PRIMARY KEY,title TEXT, url TEXT, path TEXT)');
      },
      version: 1,
    );
  }

  static Future<bool> isAvailable(String table, String id) async {
    final database = await DBHelper.database(table);
    var query = await database.query(table, where: 'id = ?', whereArgs: [id]);
    // print("query ${query}");
    if (query.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final database = await DBHelper.database(table);
    // print("database $database");
    database.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<void> updatePath(String table, String id, String path) async {
    print("before accessing database...");
    final database = await DBHelper.database(table);
    String updateQuery;
    if (table == "Readings") {
      updateQuery = 'UPDATE Readings SET path ="' +
          path +
          '" WHERE id ="' +
          id.toString() +
          '"';
    } else {
      updateQuery = 'UPDATE Podcasts SET path ="' +
          path +
          '" WHERE id ="' +
          id.toString() +
          '"';
    }
    print("after accessing database...");

    var update = await database
        .rawUpdate('''UPDATE $table SET path = ? WHERE id = ? ''', [path, id]);
    print("update ${update}");
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    // print("getting database");
    final database = await DBHelper.database(table);
    // print("finished");
    var result = await database.query(table);
    return result;
  }
}
