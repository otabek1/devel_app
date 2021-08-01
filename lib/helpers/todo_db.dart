import 'package:devel_app/models/todo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class TodoDB {
  static Future<sql.Database> database() async {
    var exPath = await getExternalStorageDirectory();
    final dbPath = path.join(exPath!.path, "todo.db");
    return await sql.openDatabase(
      dbPath,
      onCreate: (sql.Database db, int version) async {
        print("creating >>> todo sql");
        await db.execute(
            'CREATE TABLE IF NOT EXISTS Todos (id TEXT PRIMARY KEY,title TEXT, description TEXT, isDone INTEGER,createdTime TEXT)');
      },
      version: 1,
    );
  }

  static Future<void> insert(Todo todo) async {
    final database = await TodoDB.database();
    var json = todo.toJson();
    print("database inserting todo");
    await database.insert("Todos", json,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    database.close();
  }
  
  static Future<void> updateDone(Todo todo) async {
    final database = await TodoDB.database();
    var json = todo.toJson();
    print("database inserting todo");
    await database.insert("Todos", json,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    database.close();
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    // print("getting database");
    final database = await TodoDB.database();
    // print("finished");
    var result = await database.query("Todos");
    print("todos from sql $result");
    return result;
  }

  static Future<bool> delete(String id) async {
    final database = await TodoDB.database();
    var delete = await database.delete("todos", where: "id=?", whereArgs: [id]);
    print("delete $delete");
    if (delete > 0) {
      return true;
    } else {
      return false;
    }
  }
}
