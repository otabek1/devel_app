import 'package:devel_app/providers/podcasts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class PodcastDb {
  static Future<sql.Database> database() async {
    var exPath = await getExternalStorageDirectory();
    final dbPath = path.join(exPath!.path, "podcasts.db");
    return await sql.openDatabase(
      dbPath,
      onCreate: (sql.Database db, int version) async {
        print("creating >>> podcast sql");
        await db.execute(
            'CREATE TABLE IF NOT EXISTS Podcasts (id TEXT PRIMARY KEY,title TEXT,url TEXT, path TEXT)');
      },
      version: 1,
    );
  }

  static Future<void> insert(Podcast podcast) async {
    final database = await PodcastDb.database();
    var json = podcast.toJson();
    print("database inserting or updatig podcast  path>> ${podcast.path}");
    await database.insert("Podcasts", json,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    // print("getting database");
    final database = await PodcastDb.database();
    // print("finished");
    var result = await database.query("Podcasts");
    print("Podcasts from sql $result");
    return result;
  }
}
