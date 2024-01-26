import 'package:sqflite/sqlite_api.dart';

import 'package:news_lib/models/article_model.dart';
import 'package:news_lib/services/sqflite_service.dart';

class NewsRepositoryLocal {
  final SqfLiteService service;

  NewsRepositoryLocal({required this.service});

  Future<List<ArticleModel>> getFavorites() async {
    final database = await service.database;

    final List<Map<String, dynamic>> results =
        await database.query('favorites');

    return List.generate(results.length, (i) {
      return ArticleModel.fromSqfLite(results[i]);
    });
  }

  Future<ArticleModel?> findFavoriteById(String id) async {
    final database = await service.database;

    final List<Map<String, dynamic>> result = await database.query(
      "favorites",
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isEmpty) return null;

    return ArticleModel.fromSqfLite(result.first);
  }

  Future addFavorite(ArticleModel article) async {
    final database = await service.database;

    await database.insert(
      'favorites',
      article.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future removeFavorite(String id) async {
    final database = await service.database;

    await database.delete(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
