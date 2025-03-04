import 'dart:io' as io;
import 'package:newproject/modal/news_Modal.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDB();
    return _db!;
  }

  initDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "news.db";
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(
    Database db,
    int version,
  ) async {
    db.execute(
        "CREATE TABLE NewsArticle (id INTEGER PRIMARY KEY, title TEXT, description TEXT, urlToImage TEXT)");
  }

  Future insertNewsArticle(NewsArticle newsArticle) async {
    var dbClient = await db;
    await dbClient!.insert('NewsArticle', newsArticle.toMap());
    return newsArticle;
  }

  Future getCartList() async {
    var dbClient = await db;
    final List<Map<String, dynamic>> maps =
        await dbClient!.query('NewsArticle');
    return List.generate(maps.length, (i) {
      return NewsArticle(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        urlToImage: maps[i]['urlToImage'],
      );
    });
  }

  Future deleteNewsArticle(int id) async {
    var dbClient = await db;
    await dbClient!.delete(
      'NewsArticle',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
