import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    var exPath = await getExternalStorageDirectory();
    final dbPath = path.join(exPath!.path, "core.db");
    return await sql.openDatabase(
      dbPath,
      onCreate: (sql.Database db, int version) async {
        await db.execute(
            'CREATE TABLE IF NOT EXISTS Readings (id TEXT PRIMARY KEY,title TEXT, sizeInMB REAL, author TEXT,isBook INTEGER, url TEXT, path TEXT)');
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final database = await DBHelper.database();
    print("database $database");
    database.insert("Readings", data,
        conflictAlgorithm: sql.ConflictAlgorithm.rollback);

    database.close();
  }

  static Future<void> updatePath(String id, String path) async {
    final database = await DBHelper.database();
    final updateQuery = 'UPDATE Readings SET path ="' +
        path +
        '" WHERE id ="' +
        id.toString() +
        '"';
    var update = await database.rawUpdate(updateQuery);
    print("update $update");
    database.close();
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    print("getting database");
    final database = await DBHelper.database();
    print("finished");
    var result = await database.query("Readings");
    database.close();
    return result;
  }
}
