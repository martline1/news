import 'package:dio/dio.dart';
import 'package:news_lib/models/article_model.dart';

import 'package:news_lib/models/news_response_model.dart';
import 'package:news_lib/repositories/news_repository.dart';
import 'package:news_lib/repositories/news_repository_local.dart';

class NewsService {
  static Future<NewsResponseModel?> getNews(String apiKey) async {
    try {
      final Response response = await NewsRepository.getNews(apiKey);

      return NewsResponseModel.fromJson(response.data);
    } catch (_) {
      return null;
    }
  }

  static Future<List<ArticleModel>> getLocalFavorites() async {
    try {
      final List<ArticleModel> localFavorites =
          await NewsRepositoryLocal.getFavorites();

      return localFavorites;
    } catch (_) {
      return List<ArticleModel>.empty(growable: false);
    }
  }

  static Future addFavorite(ArticleModel article) async {
    try {
      final ArticleModel? articleInDB =
          await NewsRepositoryLocal.findFavoriteById(article.id);

      // Element already exists in the database
      if (articleInDB != null) return;

      // Else create it
      await NewsRepositoryLocal.addFavorite(article);
    } catch (_) {
      return;
    }
  }

  static Future removeFavoriteIfExists(String id) async {
    try {
      final ArticleModel? articleInDB =
          await NewsRepositoryLocal.findFavoriteById(id);

      // Element doesn't exists in the database
      if (articleInDB == null) return;

      // if exists, delete it
      await NewsRepositoryLocal.removeFavorite(id);
    } catch (_) {
      return;
    }
  }
}
