import 'package:news_lib/repositories/news_repository_local.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfLiteService {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _init();
    return _database!;
  }

  static Future<String> getFullPath() async {
    // If working with multiple dbs, this should be in
    // an env file
    const String name = 'news_app.db';
    final path = await getDatabasesPath();

    return join(path, name);
  }

  static Future<Database> _init() async {
    final path = await getFullPath();

    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      singleInstance: true,
    );

    return database;
  }

  static Future _onCreate(Database database, int version) async {
    return NewsRepositoryLocal.initDatabase(database);
  }
}
