import 'package:devel_app/providers/readings.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class ReadingDb {
  static Future<sql.Database> database() async {
    var exPath = await getExternalStorageDirectory();
    final dbPath = path.join(exPath!.path, "readings.db");
    return await sql.openDatabase(
      dbPath,
      onCreate: (sql.Database db, int version) async {
        print("creating >>> reading sql");
        await db.execute(
            'CREATE TABLE IF NOT EXISTS Readings (id TEXT PRIMARY KEY,title TEXT,author TEXT,isBook INTEGER, url TEXT, path TEXT)');
      },
      version: 1,
    );
  }

  static Future<void> insert(Reading reading) async {
    final database = await ReadingDb.database();
    var json = reading.toJson();
    print("database inserting or updatig reading  path>> ${reading.path}");
    await database.insert("Readings", json,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    // print("getting database");
    final database = await ReadingDb.database();
    // print("finished");
    var result = await database.query("Readings");
    print("readings from sql $result");
    return result;
  }
}
