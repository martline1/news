import 'package:sqflite/sqlite_api.dart';

import 'package:news_lib/models/article_model.dart';
import 'package:news_lib/services/sqflite_service.dart';

class NewsRepositoryLocal {
  static Future initDatabase(Database database) async {
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

  static Future<List<ArticleModel>> getFavorites() async {
    final database = await SqfLiteService.database;

    final List<Map<String, dynamic>> results =
        await database.query('favorites');

    return List.generate(results.length, (i) {
      return ArticleModel.fromSqfLite(results[i]);
    });
  }

  static Future<ArticleModel?> findFavoriteById(String id) async {
    final database = await SqfLiteService.database;

    final List<Map<String, dynamic>> result = await database.query(
      "favorites",
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isEmpty) return null;

    return ArticleModel.fromSqfLite(result.first);
  }

  static Future addFavorite(ArticleModel article) async {
    final database = await SqfLiteService.database;

    await database.insert(
      'favorites',
      article.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future removeFavorite(String id) async {
    final database = await SqfLiteService.database;

    await database.delete(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
