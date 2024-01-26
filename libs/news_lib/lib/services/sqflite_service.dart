import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfLiteService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _init();
    return _database!;
  }

  Future<String> getFullPath() async {
    // If working with multiple dbs, this should be in
    // an env file
    const String name = 'news_app.db';
    final path = await getDatabasesPath();

    return join(path, name);
  }

  Future<Database> _init() async {
    final path = await getFullPath();

    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      singleInstance: true,
    );

    return database;
  }

  Future _onCreate(Database database, int version) async {
    await database.execute("""
      CREATE TABLE IF NOT EXISTS favorites (
        "id" TEXT UNIQUE NOT NULL,
        "sourceName" TEXT NOT NULL,
        "author" TEXT NOT NULL,
        "title" TEXT NOT NULL,
        "description" TEXT NOT NULL,
        "url" TEXT NOT NULL,
        "urlToImage" TEXT NOT NULL,
        "content" TEXT NOT NULL
      );
    """);
  }
}
