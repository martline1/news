import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:news_lib/models/article_model.dart';
import 'package:news_lib/models/news_response_model.dart';
import 'package:news_lib/services/news_service.dart';

class MockNewsService extends Mock implements NewsService {
  final ArticleModel article;

  MockNewsService(this.article);

  @override
  Future addFavorite(ArticleModel article) async {}

  @override
  Future removeFavoriteIfExists(String id) async {}

  @override
  Future<NewsResponseModel?> getNews(String apiKey) async {
    return NewsResponseModel(
      status: "200",
      totalResults: 1,
      articles: [article],
    );
  }
}
