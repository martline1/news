import 'package:dio/dio.dart';
import 'package:news_lib/models/article_model.dart';

import 'package:news_lib/models/news_response_model.dart';
import 'package:news_lib/repositories/news_repository.dart';
import 'package:news_lib/repositories/news_repository_local.dart';

class NewsService {
  final NewsRepository repository;
  final NewsRepositoryLocal repositoryLocal;

  NewsService({
    required this.repository,
    required this.repositoryLocal,
  });

  Future<NewsResponseModel?> getNews(String apiKey) async {
    try {
      final Response response = await repository.getNews(apiKey);

      return NewsResponseModel.fromJson(response.data);
    } catch (_) {
      return null;
    }
  }

  Future<List<ArticleModel>> getLocalFavorites() async {
    try {
      final List<ArticleModel> localFavorites =
          await repositoryLocal.getFavorites();

      return localFavorites;
    } catch (_) {
      return List<ArticleModel>.empty(growable: false);
    }
  }

  Future addFavorite(ArticleModel article) async {
    try {
      final ArticleModel? articleInDB =
          await repositoryLocal.findFavoriteById(article.id);

      // Element already exists in the database
      if (articleInDB != null) return;

      // Else create it
      await repositoryLocal.addFavorite(article);
    } catch (_) {
      return;
    }
  }

  Future removeFavoriteIfExists(String id) async {
    try {
      final ArticleModel? articleInDB =
          await repositoryLocal.findFavoriteById(id);

      // Element doesn't exists in the database
      if (articleInDB == null) return;

      // if exists, delete it
      await repositoryLocal.removeFavorite(id);
    } catch (_) {
      return;
    }
  }
}
